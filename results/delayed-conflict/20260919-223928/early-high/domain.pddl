(define (domain delayed-conflict-early-high)
  (:requirements :strips :fluents)
  (:constants root good-1 good-2 good-3 good-4 good-5 good-6 good-7 good-8 bad-1-0-0 bad-1-0-1 bad-1-0-2 bad-2-0-0 bad-2-0-1 bad-2-0-2 bad-2-1-0 bad-2-1-1 bad-2-1-2 bad-2-2-0 bad-2-2-1 bad-2-2-2 bad-3-0-0 bad-3-0-1 bad-3-0-2 bad-3-1-0 bad-3-1-1 bad-3-1-2 bad-3-2-0 bad-3-2-1 bad-3-2-2 bad-3-3-0 bad-3-3-1 bad-3-3-2 bad-3-4-0 bad-3-4-1 bad-3-4-2 bad-3-5-0 bad-3-5-1 bad-3-5-2 bad-3-6-0 bad-3-6-1 bad-3-6-2 bad-3-7-0 bad-3-7-1 bad-3-7-2 bad-3-8-0 bad-3-8-1 bad-3-8-2 bad-4-0-0 bad-4-0-1 bad-4-0-2 bad-4-1-0 bad-4-1-1 bad-4-1-2 bad-4-2-0 bad-4-2-1 bad-4-2-2 bad-4-3-0 bad-4-3-1 bad-4-3-2 bad-4-4-0 bad-4-4-1 bad-4-4-2 bad-4-5-0 bad-4-5-1 bad-4-5-2 bad-4-6-0 bad-4-6-1 bad-4-6-2 bad-4-7-0 bad-4-7-1 bad-4-7-2 bad-4-8-0 bad-4-8-1 bad-4-8-2 bad-4-9-0 bad-4-9-1 bad-4-9-2 bad-4-10-0 bad-4-10-1 bad-4-10-2 bad-4-11-0 bad-4-11-1 bad-4-11-2 bad-4-12-0 bad-4-12-1 bad-4-12-2 bad-4-13-0 bad-4-13-1 bad-4-13-2 bad-4-14-0 bad-4-14-1 bad-4-14-2 bad-4-15-0 bad-4-15-1 bad-4-15-2 bad-4-16-0 bad-4-16-1 bad-4-16-2 bad-4-17-0 bad-4-17-1 bad-4-17-2 bad-4-18-0 bad-4-18-1 bad-4-18-2 bad-4-19-0 bad-4-19-1 bad-4-19-2 bad-4-20-0 bad-4-20-1 bad-4-20-2 bad-4-21-0 bad-4-21-1 bad-4-21-2 bad-4-22-0 bad-4-22-1 bad-4-22-2 bad-4-23-0 bad-4-23-1 bad-4-23-2 bad-4-24-0 bad-4-24-1 bad-4-24-2 bad-4-25-0 bad-4-25-1 bad-4-25-2 bad-4-26-0 bad-4-26-1 bad-4-26-2 bad-5-0-0 bad-5-0-1 bad-5-0-2 bad-5-1-0 bad-5-1-1 bad-5-1-2 bad-5-2-0 bad-5-2-1 bad-5-2-2 bad-5-3-0 bad-5-3-1 bad-5-3-2 bad-5-4-0 bad-5-4-1 bad-5-4-2 bad-5-5-0 bad-5-5-1 bad-5-5-2 bad-5-6-0 bad-5-6-1 bad-5-6-2 bad-5-7-0 bad-5-7-1 bad-5-7-2 bad-5-8-0 bad-5-8-1 bad-5-8-2 bad-5-9-0 bad-5-9-1 bad-5-9-2 bad-5-10-0 bad-5-10-1 bad-5-10-2 bad-5-11-0 bad-5-11-1 bad-5-11-2 bad-5-12-0 bad-5-12-1 bad-5-12-2 bad-5-13-0 bad-5-13-1 bad-5-13-2 bad-5-14-0 bad-5-14-1 bad-5-14-2 bad-5-15-0 bad-5-15-1 bad-5-15-2 bad-5-16-0 bad-5-16-1 bad-5-16-2 bad-5-17-0 bad-5-17-1 bad-5-17-2 bad-5-18-0 bad-5-18-1 bad-5-18-2 bad-5-19-0 bad-5-19-1 bad-5-19-2 bad-5-20-0 bad-5-20-1 bad-5-20-2 bad-5-21-0 bad-5-21-1 bad-5-21-2 bad-5-22-0 bad-5-22-1 bad-5-22-2 bad-5-23-0 bad-5-23-1 bad-5-23-2 bad-5-24-0 bad-5-24-1 bad-5-24-2 bad-5-25-0 bad-5-25-1 bad-5-25-2 bad-5-26-0 bad-5-26-1 bad-5-26-2 bad-5-27-0 bad-5-27-1 bad-5-27-2 bad-5-28-0 bad-5-28-1 bad-5-28-2 bad-5-29-0 bad-5-29-1 bad-5-29-2 bad-5-30-0 bad-5-30-1 bad-5-30-2 bad-5-31-0 bad-5-31-1 bad-5-31-2 bad-5-32-0 bad-5-32-1 bad-5-32-2 bad-5-33-0 bad-5-33-1 bad-5-33-2 bad-5-34-0 bad-5-34-1 bad-5-34-2 bad-5-35-0 bad-5-35-1 bad-5-35-2 bad-5-36-0 bad-5-36-1 bad-5-36-2 bad-5-37-0 bad-5-37-1 bad-5-37-2 bad-5-38-0 bad-5-38-1 bad-5-38-2 bad-5-39-0 bad-5-39-1 bad-5-39-2 bad-5-40-0 bad-5-40-1 bad-5-40-2 bad-5-41-0 bad-5-41-1 bad-5-41-2 bad-5-42-0 bad-5-42-1 bad-5-42-2 bad-5-43-0 bad-5-43-1 bad-5-43-2 bad-5-44-0 bad-5-44-1 bad-5-44-2 bad-5-45-0 bad-5-45-1 bad-5-45-2 bad-5-46-0 bad-5-46-1 bad-5-46-2 bad-5-47-0 bad-5-47-1 bad-5-47-2 bad-5-48-0 bad-5-48-1 bad-5-48-2 bad-5-49-0 bad-5-49-1 bad-5-49-2 bad-5-50-0 bad-5-50-1 bad-5-50-2 bad-5-51-0 bad-5-51-1 bad-5-51-2 bad-5-52-0 bad-5-52-1 bad-5-52-2 bad-5-53-0 bad-5-53-1 bad-5-53-2 bad-5-54-0 bad-5-54-1 bad-5-54-2 bad-5-55-0 bad-5-55-1 bad-5-55-2 bad-5-56-0 bad-5-56-1 bad-5-56-2 bad-5-57-0 bad-5-57-1 bad-5-57-2 bad-5-58-0 bad-5-58-1 bad-5-58-2 bad-5-59-0 bad-5-59-1 bad-5-59-2 bad-5-60-0 bad-5-60-1 bad-5-60-2 bad-5-61-0 bad-5-61-1 bad-5-61-2 bad-5-62-0 bad-5-62-1 bad-5-62-2 bad-5-63-0 bad-5-63-1 bad-5-63-2 bad-5-64-0 bad-5-64-1 bad-5-64-2 bad-5-65-0 bad-5-65-1 bad-5-65-2 bad-5-66-0 bad-5-66-1 bad-5-66-2 bad-5-67-0 bad-5-67-1 bad-5-67-2 bad-5-68-0 bad-5-68-1 bad-5-68-2 bad-5-69-0 bad-5-69-1 bad-5-69-2 bad-5-70-0 bad-5-70-1 bad-5-70-2 bad-5-71-0 bad-5-71-1 bad-5-71-2 bad-5-72-0 bad-5-72-1 bad-5-72-2 bad-5-73-0 bad-5-73-1 bad-5-73-2 bad-5-74-0 bad-5-74-1 bad-5-74-2 bad-5-75-0 bad-5-75-1 bad-5-75-2 bad-5-76-0 bad-5-76-1 bad-5-76-2 bad-5-77-0 bad-5-77-1 bad-5-77-2 bad-5-78-0 bad-5-78-1 bad-5-78-2 bad-5-79-0 bad-5-79-1 bad-5-79-2 bad-5-80-0 bad-5-80-1 bad-5-80-2 bad-6-0-0 bad-6-0-1 bad-6-0-2 bad-6-1-0 bad-6-1-1 bad-6-1-2 bad-6-2-0 bad-6-2-1 bad-6-2-2 bad-6-3-0 bad-6-3-1 bad-6-3-2 bad-6-4-0 bad-6-4-1 bad-6-4-2 bad-6-5-0 bad-6-5-1 bad-6-5-2 bad-6-6-0 bad-6-6-1 bad-6-6-2 bad-6-7-0 bad-6-7-1 bad-6-7-2 bad-6-8-0 bad-6-8-1 bad-6-8-2 bad-6-9-0 bad-6-9-1 bad-6-9-2 bad-6-10-0 bad-6-10-1 bad-6-10-2 bad-6-11-0 bad-6-11-1 bad-6-11-2 bad-6-12-0 bad-6-12-1 bad-6-12-2 bad-6-13-0 bad-6-13-1 bad-6-13-2 bad-6-14-0 bad-6-14-1 bad-6-14-2 bad-6-15-0 bad-6-15-1 bad-6-15-2 bad-6-16-0 bad-6-16-1 bad-6-16-2 bad-6-17-0 bad-6-17-1 bad-6-17-2 bad-6-18-0 bad-6-18-1 bad-6-18-2 bad-6-19-0 bad-6-19-1 bad-6-19-2 bad-6-20-0 bad-6-20-1 bad-6-20-2 bad-6-21-0 bad-6-21-1 bad-6-21-2 bad-6-22-0 bad-6-22-1 bad-6-22-2 bad-6-23-0 bad-6-23-1 bad-6-23-2 bad-6-24-0 bad-6-24-1 bad-6-24-2 bad-6-25-0 bad-6-25-1 bad-6-25-2 bad-6-26-0 bad-6-26-1 bad-6-26-2 bad-6-27-0 bad-6-27-1 bad-6-27-2 bad-6-28-0 bad-6-28-1 bad-6-28-2 bad-6-29-0 bad-6-29-1 bad-6-29-2 bad-6-30-0 bad-6-30-1 bad-6-30-2 bad-6-31-0 bad-6-31-1 bad-6-31-2 bad-6-32-0 bad-6-32-1 bad-6-32-2 bad-6-33-0 bad-6-33-1 bad-6-33-2 bad-6-34-0 bad-6-34-1 bad-6-34-2 bad-6-35-0 bad-6-35-1 bad-6-35-2 bad-6-36-0 bad-6-36-1 bad-6-36-2 bad-6-37-0 bad-6-37-1 bad-6-37-2 bad-6-38-0 bad-6-38-1 bad-6-38-2 bad-6-39-0 bad-6-39-1 bad-6-39-2 bad-6-40-0 bad-6-40-1 bad-6-40-2 bad-6-41-0 bad-6-41-1 bad-6-41-2 bad-6-42-0 bad-6-42-1 bad-6-42-2 bad-6-43-0 bad-6-43-1 bad-6-43-2 bad-6-44-0 bad-6-44-1 bad-6-44-2 bad-6-45-0 bad-6-45-1 bad-6-45-2 bad-6-46-0 bad-6-46-1 bad-6-46-2 bad-6-47-0 bad-6-47-1 bad-6-47-2 bad-6-48-0 bad-6-48-1 bad-6-48-2 bad-6-49-0 bad-6-49-1 bad-6-49-2 bad-6-50-0 bad-6-50-1 bad-6-50-2 bad-6-51-0 bad-6-51-1 bad-6-51-2 bad-6-52-0 bad-6-52-1 bad-6-52-2 bad-6-53-0 bad-6-53-1 bad-6-53-2 bad-6-54-0 bad-6-54-1 bad-6-54-2 bad-6-55-0 bad-6-55-1 bad-6-55-2 bad-6-56-0 bad-6-56-1 bad-6-56-2 bad-6-57-0 bad-6-57-1 bad-6-57-2 bad-6-58-0 bad-6-58-1 bad-6-58-2 bad-6-59-0 bad-6-59-1 bad-6-59-2 bad-6-60-0 bad-6-60-1 bad-6-60-2 bad-6-61-0 bad-6-61-1 bad-6-61-2 bad-6-62-0 bad-6-62-1 bad-6-62-2 bad-6-63-0 bad-6-63-1 bad-6-63-2 bad-6-64-0 bad-6-64-1 bad-6-64-2 bad-6-65-0 bad-6-65-1 bad-6-65-2 bad-6-66-0 bad-6-66-1 bad-6-66-2 bad-6-67-0 bad-6-67-1 bad-6-67-2 bad-6-68-0 bad-6-68-1 bad-6-68-2 bad-6-69-0 bad-6-69-1 bad-6-69-2 bad-6-70-0 bad-6-70-1 bad-6-70-2 bad-6-71-0 bad-6-71-1 bad-6-71-2 bad-6-72-0 bad-6-72-1 bad-6-72-2 bad-6-73-0 bad-6-73-1 bad-6-73-2 bad-6-74-0 bad-6-74-1 bad-6-74-2 bad-6-75-0 bad-6-75-1 bad-6-75-2 bad-6-76-0 bad-6-76-1 bad-6-76-2 bad-6-77-0 bad-6-77-1 bad-6-77-2 bad-6-78-0 bad-6-78-1 bad-6-78-2 bad-6-79-0 bad-6-79-1 bad-6-79-2 bad-6-80-0 bad-6-80-1 bad-6-80-2 bad-6-81-0 bad-6-81-1 bad-6-81-2 bad-6-82-0 bad-6-82-1 bad-6-82-2 bad-6-83-0 bad-6-83-1 bad-6-83-2 bad-6-84-0 bad-6-84-1 bad-6-84-2 bad-6-85-0 bad-6-85-1 bad-6-85-2 bad-6-86-0 bad-6-86-1 bad-6-86-2 bad-6-87-0 bad-6-87-1 bad-6-87-2 bad-6-88-0 bad-6-88-1 bad-6-88-2 bad-6-89-0 bad-6-89-1 bad-6-89-2 bad-6-90-0 bad-6-90-1 bad-6-90-2 bad-6-91-0 bad-6-91-1 bad-6-91-2 bad-6-92-0 bad-6-92-1 bad-6-92-2 bad-6-93-0 bad-6-93-1 bad-6-93-2 bad-6-94-0 bad-6-94-1 bad-6-94-2 bad-6-95-0 bad-6-95-1 bad-6-95-2 bad-6-96-0 bad-6-96-1 bad-6-96-2 bad-6-97-0 bad-6-97-1 bad-6-97-2 bad-6-98-0 bad-6-98-1 bad-6-98-2 bad-6-99-0 bad-6-99-1 bad-6-99-2 bad-6-100-0 bad-6-100-1 bad-6-100-2 bad-6-101-0 bad-6-101-1 bad-6-101-2 bad-6-102-0 bad-6-102-1 bad-6-102-2 bad-6-103-0 bad-6-103-1 bad-6-103-2 bad-6-104-0 bad-6-104-1 bad-6-104-2 bad-6-105-0 bad-6-105-1 bad-6-105-2 bad-6-106-0 bad-6-106-1 bad-6-106-2 bad-6-107-0 bad-6-107-1 bad-6-107-2 bad-6-108-0 bad-6-108-1 bad-6-108-2 bad-6-109-0 bad-6-109-1 bad-6-109-2 bad-6-110-0 bad-6-110-1 bad-6-110-2 bad-6-111-0 bad-6-111-1 bad-6-111-2 bad-6-112-0 bad-6-112-1 bad-6-112-2 bad-6-113-0 bad-6-113-1 bad-6-113-2 bad-6-114-0 bad-6-114-1 bad-6-114-2 bad-6-115-0 bad-6-115-1 bad-6-115-2 bad-6-116-0 bad-6-116-1 bad-6-116-2 bad-6-117-0 bad-6-117-1 bad-6-117-2 bad-6-118-0 bad-6-118-1 bad-6-118-2 bad-6-119-0 bad-6-119-1 bad-6-119-2 bad-6-120-0 bad-6-120-1 bad-6-120-2 bad-6-121-0 bad-6-121-1 bad-6-121-2 bad-6-122-0 bad-6-122-1 bad-6-122-2 bad-6-123-0 bad-6-123-1 bad-6-123-2 bad-6-124-0 bad-6-124-1 bad-6-124-2 bad-6-125-0 bad-6-125-1 bad-6-125-2 bad-6-126-0 bad-6-126-1 bad-6-126-2 bad-6-127-0 bad-6-127-1 bad-6-127-2 bad-6-128-0 bad-6-128-1 bad-6-128-2 bad-6-129-0 bad-6-129-1 bad-6-129-2 bad-6-130-0 bad-6-130-1 bad-6-130-2 bad-6-131-0 bad-6-131-1 bad-6-131-2 bad-6-132-0 bad-6-132-1 bad-6-132-2 bad-6-133-0 bad-6-133-1 bad-6-133-2 bad-6-134-0 bad-6-134-1 bad-6-134-2 bad-6-135-0 bad-6-135-1 bad-6-135-2 bad-6-136-0 bad-6-136-1 bad-6-136-2 bad-6-137-0 bad-6-137-1 bad-6-137-2 bad-6-138-0 bad-6-138-1 bad-6-138-2 bad-6-139-0 bad-6-139-1 bad-6-139-2 bad-6-140-0 bad-6-140-1 bad-6-140-2 bad-6-141-0 bad-6-141-1 bad-6-141-2 bad-6-142-0 bad-6-142-1 bad-6-142-2 bad-6-143-0 bad-6-143-1 bad-6-143-2 bad-6-144-0 bad-6-144-1 bad-6-144-2 bad-6-145-0 bad-6-145-1 bad-6-145-2 bad-6-146-0 bad-6-146-1 bad-6-146-2 bad-6-147-0 bad-6-147-1 bad-6-147-2 bad-6-148-0 bad-6-148-1 bad-6-148-2 bad-6-149-0 bad-6-149-1 bad-6-149-2 bad-6-150-0 bad-6-150-1 bad-6-150-2 bad-6-151-0 bad-6-151-1 bad-6-151-2 bad-6-152-0 bad-6-152-1 bad-6-152-2 bad-6-153-0 bad-6-153-1 bad-6-153-2 bad-6-154-0 bad-6-154-1 bad-6-154-2 bad-6-155-0 bad-6-155-1 bad-6-155-2 bad-6-156-0 bad-6-156-1 bad-6-156-2 bad-6-157-0 bad-6-157-1 bad-6-157-2 bad-6-158-0 bad-6-158-1 bad-6-158-2 bad-6-159-0 bad-6-159-1 bad-6-159-2 bad-6-160-0 bad-6-160-1 bad-6-160-2 bad-6-161-0 bad-6-161-1 bad-6-161-2 bad-6-162-0 bad-6-162-1 bad-6-162-2 bad-6-163-0 bad-6-163-1 bad-6-163-2 bad-6-164-0 bad-6-164-1 bad-6-164-2 bad-6-165-0 bad-6-165-1 bad-6-165-2 bad-6-166-0 bad-6-166-1 bad-6-166-2 bad-6-167-0 bad-6-167-1 bad-6-167-2 bad-6-168-0 bad-6-168-1 bad-6-168-2 bad-6-169-0 bad-6-169-1 bad-6-169-2 bad-6-170-0 bad-6-170-1 bad-6-170-2 bad-6-171-0 bad-6-171-1 bad-6-171-2 bad-6-172-0 bad-6-172-1 bad-6-172-2 bad-6-173-0 bad-6-173-1 bad-6-173-2 bad-6-174-0 bad-6-174-1 bad-6-174-2 bad-6-175-0 bad-6-175-1 bad-6-175-2 bad-6-176-0 bad-6-176-1 bad-6-176-2 bad-6-177-0 bad-6-177-1 bad-6-177-2 bad-6-178-0 bad-6-178-1 bad-6-178-2 bad-6-179-0 bad-6-179-1 bad-6-179-2 bad-6-180-0 bad-6-180-1 bad-6-180-2 bad-6-181-0 bad-6-181-1 bad-6-181-2 bad-6-182-0 bad-6-182-1 bad-6-182-2 bad-6-183-0 bad-6-183-1 bad-6-183-2 bad-6-184-0 bad-6-184-1 bad-6-184-2 bad-6-185-0 bad-6-185-1 bad-6-185-2 bad-6-186-0 bad-6-186-1 bad-6-186-2 bad-6-187-0 bad-6-187-1 bad-6-187-2 bad-6-188-0 bad-6-188-1 bad-6-188-2 bad-6-189-0 bad-6-189-1 bad-6-189-2 bad-6-190-0 bad-6-190-1 bad-6-190-2 bad-6-191-0 bad-6-191-1 bad-6-191-2 bad-6-192-0 bad-6-192-1 bad-6-192-2 bad-6-193-0 bad-6-193-1 bad-6-193-2 bad-6-194-0 bad-6-194-1 bad-6-194-2 bad-6-195-0 bad-6-195-1 bad-6-195-2 bad-6-196-0 bad-6-196-1 bad-6-196-2 bad-6-197-0 bad-6-197-1 bad-6-197-2 bad-6-198-0 bad-6-198-1 bad-6-198-2 bad-6-199-0 bad-6-199-1 bad-6-199-2 bad-6-200-0 bad-6-200-1 bad-6-200-2 bad-6-201-0 bad-6-201-1 bad-6-201-2 bad-6-202-0 bad-6-202-1 bad-6-202-2 bad-6-203-0 bad-6-203-1 bad-6-203-2 bad-6-204-0 bad-6-204-1 bad-6-204-2 bad-6-205-0 bad-6-205-1 bad-6-205-2 bad-6-206-0 bad-6-206-1 bad-6-206-2 bad-6-207-0 bad-6-207-1 bad-6-207-2 bad-6-208-0 bad-6-208-1 bad-6-208-2 bad-6-209-0 bad-6-209-1 bad-6-209-2 bad-6-210-0 bad-6-210-1 bad-6-210-2 bad-6-211-0 bad-6-211-1 bad-6-211-2 bad-6-212-0 bad-6-212-1 bad-6-212-2 bad-6-213-0 bad-6-213-1 bad-6-213-2 bad-6-214-0 bad-6-214-1 bad-6-214-2 bad-6-215-0 bad-6-215-1 bad-6-215-2 bad-6-216-0 bad-6-216-1 bad-6-216-2 bad-6-217-0 bad-6-217-1 bad-6-217-2 bad-6-218-0 bad-6-218-1 bad-6-218-2 bad-6-219-0 bad-6-219-1 bad-6-219-2 bad-6-220-0 bad-6-220-1 bad-6-220-2 bad-6-221-0 bad-6-221-1 bad-6-221-2 bad-6-222-0 bad-6-222-1 bad-6-222-2 bad-6-223-0 bad-6-223-1 bad-6-223-2 bad-6-224-0 bad-6-224-1 bad-6-224-2 bad-6-225-0 bad-6-225-1 bad-6-225-2 bad-6-226-0 bad-6-226-1 bad-6-226-2 bad-6-227-0 bad-6-227-1 bad-6-227-2 bad-6-228-0 bad-6-228-1 bad-6-228-2 bad-6-229-0 bad-6-229-1 bad-6-229-2 bad-6-230-0 bad-6-230-1 bad-6-230-2 bad-6-231-0 bad-6-231-1 bad-6-231-2 bad-6-232-0 bad-6-232-1 bad-6-232-2 bad-6-233-0 bad-6-233-1 bad-6-233-2 bad-6-234-0 bad-6-234-1 bad-6-234-2 bad-6-235-0 bad-6-235-1 bad-6-235-2 bad-6-236-0 bad-6-236-1 bad-6-236-2 bad-6-237-0 bad-6-237-1 bad-6-237-2 bad-6-238-0 bad-6-238-1 bad-6-238-2 bad-6-239-0 bad-6-239-1 bad-6-239-2 bad-6-240-0 bad-6-240-1 bad-6-240-2 bad-6-241-0 bad-6-241-1 bad-6-241-2 bad-6-242-0 bad-6-242-1 bad-6-242-2)
  (:predicates (at ?n) (done))
  (:functions (fuel) (total-cost))
  (:action z-good-1
    :parameters ()
    :precondition (and (at root))
    :effect (and (not (at root)) (at good-1) (increase (total-cost) 1)))

  (:action z-good-2
    :parameters ()
    :precondition (and (at good-1))
    :effect (and (not (at good-1)) (at good-2) (increase (total-cost) 1)))

  (:action z-good-3
    :parameters ()
    :precondition (and (at good-2))
    :effect (and (not (at good-2)) (at good-3) (increase (total-cost) 1)))

  (:action z-good-4
    :parameters ()
    :precondition (and (at good-3))
    :effect (and (not (at good-3)) (at good-4) (increase (total-cost) 1)))

  (:action z-good-5
    :parameters ()
    :precondition (and (at good-4))
    :effect (and (not (at good-4)) (at good-5) (increase (total-cost) 1)))

  (:action z-good-6
    :parameters ()
    :precondition (and (at good-5))
    :effect (and (not (at good-5)) (at good-6) (increase (total-cost) 1)))

  (:action z-good-7
    :parameters ()
    :precondition (and (at good-6))
    :effect (and (not (at good-6)) (at good-7) (increase (total-cost) 1)))

  (:action z-good-8
    :parameters ()
    :precondition (and (at good-7))
    :effect (and (not (at good-7)) (at good-8) (increase (total-cost) 1)))

  (:action a-bad-1-0-0
    :parameters ()
    :precondition (and (at root) (>= (fuel) 1))
    :effect (and (not (at root)) (at bad-1-0-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-1-0-1
    :parameters ()
    :precondition (and (at root) (>= (fuel) 1))
    :effect (and (not (at root)) (at bad-1-0-1) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-1-0-2
    :parameters ()
    :precondition (and (at root) (>= (fuel) 1))
    :effect (and (not (at root)) (at bad-1-0-2) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-2-0-0
    :parameters ()
    :precondition (and (at bad-1-0-0) (>= (fuel) 1))
    :effect (and (not (at bad-1-0-0)) (at bad-2-0-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-2-0-1
    :parameters ()
    :precondition (and (at bad-1-0-0) (>= (fuel) 1))
    :effect (and (not (at bad-1-0-0)) (at bad-2-0-1) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-2-0-2
    :parameters ()
    :precondition (and (at bad-1-0-0) (>= (fuel) 1))
    :effect (and (not (at bad-1-0-0)) (at bad-2-0-2) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-2-1-0
    :parameters ()
    :precondition (and (at bad-1-0-1) (>= (fuel) 1))
    :effect (and (not (at bad-1-0-1)) (at bad-2-1-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-2-1-1
    :parameters ()
    :precondition (and (at bad-1-0-1) (>= (fuel) 1))
    :effect (and (not (at bad-1-0-1)) (at bad-2-1-1) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-2-1-2
    :parameters ()
    :precondition (and (at bad-1-0-1) (>= (fuel) 1))
    :effect (and (not (at bad-1-0-1)) (at bad-2-1-2) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-2-2-0
    :parameters ()
    :precondition (and (at bad-1-0-2) (>= (fuel) 1))
    :effect (and (not (at bad-1-0-2)) (at bad-2-2-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-2-2-1
    :parameters ()
    :precondition (and (at bad-1-0-2) (>= (fuel) 1))
    :effect (and (not (at bad-1-0-2)) (at bad-2-2-1) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-2-2-2
    :parameters ()
    :precondition (and (at bad-1-0-2) (>= (fuel) 1))
    :effect (and (not (at bad-1-0-2)) (at bad-2-2-2) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-0-0
    :parameters ()
    :precondition (and (at bad-2-0-0) (>= (fuel) 1))
    :effect (and (not (at bad-2-0-0)) (at bad-3-0-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-0-1
    :parameters ()
    :precondition (and (at bad-2-0-0) (>= (fuel) 1))
    :effect (and (not (at bad-2-0-0)) (at bad-3-0-1) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-0-2
    :parameters ()
    :precondition (and (at bad-2-0-0) (>= (fuel) 1))
    :effect (and (not (at bad-2-0-0)) (at bad-3-0-2) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-1-0
    :parameters ()
    :precondition (and (at bad-2-0-1) (>= (fuel) 1))
    :effect (and (not (at bad-2-0-1)) (at bad-3-1-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-1-1
    :parameters ()
    :precondition (and (at bad-2-0-1) (>= (fuel) 1))
    :effect (and (not (at bad-2-0-1)) (at bad-3-1-1) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-1-2
    :parameters ()
    :precondition (and (at bad-2-0-1) (>= (fuel) 1))
    :effect (and (not (at bad-2-0-1)) (at bad-3-1-2) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-2-0
    :parameters ()
    :precondition (and (at bad-2-0-2) (>= (fuel) 1))
    :effect (and (not (at bad-2-0-2)) (at bad-3-2-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-2-1
    :parameters ()
    :precondition (and (at bad-2-0-2) (>= (fuel) 1))
    :effect (and (not (at bad-2-0-2)) (at bad-3-2-1) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-2-2
    :parameters ()
    :precondition (and (at bad-2-0-2) (>= (fuel) 1))
    :effect (and (not (at bad-2-0-2)) (at bad-3-2-2) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-3-0
    :parameters ()
    :precondition (and (at bad-2-1-0) (>= (fuel) 1))
    :effect (and (not (at bad-2-1-0)) (at bad-3-3-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-3-1
    :parameters ()
    :precondition (and (at bad-2-1-0) (>= (fuel) 1))
    :effect (and (not (at bad-2-1-0)) (at bad-3-3-1) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-3-2
    :parameters ()
    :precondition (and (at bad-2-1-0) (>= (fuel) 1))
    :effect (and (not (at bad-2-1-0)) (at bad-3-3-2) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-4-0
    :parameters ()
    :precondition (and (at bad-2-1-1) (>= (fuel) 1))
    :effect (and (not (at bad-2-1-1)) (at bad-3-4-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-4-1
    :parameters ()
    :precondition (and (at bad-2-1-1) (>= (fuel) 1))
    :effect (and (not (at bad-2-1-1)) (at bad-3-4-1) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-4-2
    :parameters ()
    :precondition (and (at bad-2-1-1) (>= (fuel) 1))
    :effect (and (not (at bad-2-1-1)) (at bad-3-4-2) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-5-0
    :parameters ()
    :precondition (and (at bad-2-1-2) (>= (fuel) 1))
    :effect (and (not (at bad-2-1-2)) (at bad-3-5-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-5-1
    :parameters ()
    :precondition (and (at bad-2-1-2) (>= (fuel) 1))
    :effect (and (not (at bad-2-1-2)) (at bad-3-5-1) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-5-2
    :parameters ()
    :precondition (and (at bad-2-1-2) (>= (fuel) 1))
    :effect (and (not (at bad-2-1-2)) (at bad-3-5-2) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-6-0
    :parameters ()
    :precondition (and (at bad-2-2-0) (>= (fuel) 1))
    :effect (and (not (at bad-2-2-0)) (at bad-3-6-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-6-1
    :parameters ()
    :precondition (and (at bad-2-2-0) (>= (fuel) 1))
    :effect (and (not (at bad-2-2-0)) (at bad-3-6-1) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-6-2
    :parameters ()
    :precondition (and (at bad-2-2-0) (>= (fuel) 1))
    :effect (and (not (at bad-2-2-0)) (at bad-3-6-2) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-7-0
    :parameters ()
    :precondition (and (at bad-2-2-1) (>= (fuel) 1))
    :effect (and (not (at bad-2-2-1)) (at bad-3-7-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-7-1
    :parameters ()
    :precondition (and (at bad-2-2-1) (>= (fuel) 1))
    :effect (and (not (at bad-2-2-1)) (at bad-3-7-1) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-7-2
    :parameters ()
    :precondition (and (at bad-2-2-1) (>= (fuel) 1))
    :effect (and (not (at bad-2-2-1)) (at bad-3-7-2) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-8-0
    :parameters ()
    :precondition (and (at bad-2-2-2) (>= (fuel) 1))
    :effect (and (not (at bad-2-2-2)) (at bad-3-8-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-8-1
    :parameters ()
    :precondition (and (at bad-2-2-2) (>= (fuel) 1))
    :effect (and (not (at bad-2-2-2)) (at bad-3-8-1) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-3-8-2
    :parameters ()
    :precondition (and (at bad-2-2-2) (>= (fuel) 1))
    :effect (and (not (at bad-2-2-2)) (at bad-3-8-2) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-4-0-0
    :parameters ()
    :precondition (and (at bad-3-0-0))
    :effect (and (not (at bad-3-0-0)) (at bad-4-0-0) (increase (total-cost) 1)))

  (:action a-bad-4-0-1
    :parameters ()
    :precondition (and (at bad-3-0-0))
    :effect (and (not (at bad-3-0-0)) (at bad-4-0-1) (increase (total-cost) 1)))

  (:action a-bad-4-0-2
    :parameters ()
    :precondition (and (at bad-3-0-0))
    :effect (and (not (at bad-3-0-0)) (at bad-4-0-2) (increase (total-cost) 1)))

  (:action a-bad-4-1-0
    :parameters ()
    :precondition (and (at bad-3-0-1))
    :effect (and (not (at bad-3-0-1)) (at bad-4-1-0) (increase (total-cost) 1)))

  (:action a-bad-4-1-1
    :parameters ()
    :precondition (and (at bad-3-0-1))
    :effect (and (not (at bad-3-0-1)) (at bad-4-1-1) (increase (total-cost) 1)))

  (:action a-bad-4-1-2
    :parameters ()
    :precondition (and (at bad-3-0-1))
    :effect (and (not (at bad-3-0-1)) (at bad-4-1-2) (increase (total-cost) 1)))

  (:action a-bad-4-2-0
    :parameters ()
    :precondition (and (at bad-3-0-2))
    :effect (and (not (at bad-3-0-2)) (at bad-4-2-0) (increase (total-cost) 1)))

  (:action a-bad-4-2-1
    :parameters ()
    :precondition (and (at bad-3-0-2))
    :effect (and (not (at bad-3-0-2)) (at bad-4-2-1) (increase (total-cost) 1)))

  (:action a-bad-4-2-2
    :parameters ()
    :precondition (and (at bad-3-0-2))
    :effect (and (not (at bad-3-0-2)) (at bad-4-2-2) (increase (total-cost) 1)))

  (:action a-bad-4-3-0
    :parameters ()
    :precondition (and (at bad-3-1-0))
    :effect (and (not (at bad-3-1-0)) (at bad-4-3-0) (increase (total-cost) 1)))

  (:action a-bad-4-3-1
    :parameters ()
    :precondition (and (at bad-3-1-0))
    :effect (and (not (at bad-3-1-0)) (at bad-4-3-1) (increase (total-cost) 1)))

  (:action a-bad-4-3-2
    :parameters ()
    :precondition (and (at bad-3-1-0))
    :effect (and (not (at bad-3-1-0)) (at bad-4-3-2) (increase (total-cost) 1)))

  (:action a-bad-4-4-0
    :parameters ()
    :precondition (and (at bad-3-1-1))
    :effect (and (not (at bad-3-1-1)) (at bad-4-4-0) (increase (total-cost) 1)))

  (:action a-bad-4-4-1
    :parameters ()
    :precondition (and (at bad-3-1-1))
    :effect (and (not (at bad-3-1-1)) (at bad-4-4-1) (increase (total-cost) 1)))

  (:action a-bad-4-4-2
    :parameters ()
    :precondition (and (at bad-3-1-1))
    :effect (and (not (at bad-3-1-1)) (at bad-4-4-2) (increase (total-cost) 1)))

  (:action a-bad-4-5-0
    :parameters ()
    :precondition (and (at bad-3-1-2))
    :effect (and (not (at bad-3-1-2)) (at bad-4-5-0) (increase (total-cost) 1)))

  (:action a-bad-4-5-1
    :parameters ()
    :precondition (and (at bad-3-1-2))
    :effect (and (not (at bad-3-1-2)) (at bad-4-5-1) (increase (total-cost) 1)))

  (:action a-bad-4-5-2
    :parameters ()
    :precondition (and (at bad-3-1-2))
    :effect (and (not (at bad-3-1-2)) (at bad-4-5-2) (increase (total-cost) 1)))

  (:action a-bad-4-6-0
    :parameters ()
    :precondition (and (at bad-3-2-0))
    :effect (and (not (at bad-3-2-0)) (at bad-4-6-0) (increase (total-cost) 1)))

  (:action a-bad-4-6-1
    :parameters ()
    :precondition (and (at bad-3-2-0))
    :effect (and (not (at bad-3-2-0)) (at bad-4-6-1) (increase (total-cost) 1)))

  (:action a-bad-4-6-2
    :parameters ()
    :precondition (and (at bad-3-2-0))
    :effect (and (not (at bad-3-2-0)) (at bad-4-6-2) (increase (total-cost) 1)))

  (:action a-bad-4-7-0
    :parameters ()
    :precondition (and (at bad-3-2-1))
    :effect (and (not (at bad-3-2-1)) (at bad-4-7-0) (increase (total-cost) 1)))

  (:action a-bad-4-7-1
    :parameters ()
    :precondition (and (at bad-3-2-1))
    :effect (and (not (at bad-3-2-1)) (at bad-4-7-1) (increase (total-cost) 1)))

  (:action a-bad-4-7-2
    :parameters ()
    :precondition (and (at bad-3-2-1))
    :effect (and (not (at bad-3-2-1)) (at bad-4-7-2) (increase (total-cost) 1)))

  (:action a-bad-4-8-0
    :parameters ()
    :precondition (and (at bad-3-2-2))
    :effect (and (not (at bad-3-2-2)) (at bad-4-8-0) (increase (total-cost) 1)))

  (:action a-bad-4-8-1
    :parameters ()
    :precondition (and (at bad-3-2-2))
    :effect (and (not (at bad-3-2-2)) (at bad-4-8-1) (increase (total-cost) 1)))

  (:action a-bad-4-8-2
    :parameters ()
    :precondition (and (at bad-3-2-2))
    :effect (and (not (at bad-3-2-2)) (at bad-4-8-2) (increase (total-cost) 1)))

  (:action a-bad-4-9-0
    :parameters ()
    :precondition (and (at bad-3-3-0))
    :effect (and (not (at bad-3-3-0)) (at bad-4-9-0) (increase (total-cost) 1)))

  (:action a-bad-4-9-1
    :parameters ()
    :precondition (and (at bad-3-3-0))
    :effect (and (not (at bad-3-3-0)) (at bad-4-9-1) (increase (total-cost) 1)))

  (:action a-bad-4-9-2
    :parameters ()
    :precondition (and (at bad-3-3-0))
    :effect (and (not (at bad-3-3-0)) (at bad-4-9-2) (increase (total-cost) 1)))

  (:action a-bad-4-10-0
    :parameters ()
    :precondition (and (at bad-3-3-1))
    :effect (and (not (at bad-3-3-1)) (at bad-4-10-0) (increase (total-cost) 1)))

  (:action a-bad-4-10-1
    :parameters ()
    :precondition (and (at bad-3-3-1))
    :effect (and (not (at bad-3-3-1)) (at bad-4-10-1) (increase (total-cost) 1)))

  (:action a-bad-4-10-2
    :parameters ()
    :precondition (and (at bad-3-3-1))
    :effect (and (not (at bad-3-3-1)) (at bad-4-10-2) (increase (total-cost) 1)))

  (:action a-bad-4-11-0
    :parameters ()
    :precondition (and (at bad-3-3-2))
    :effect (and (not (at bad-3-3-2)) (at bad-4-11-0) (increase (total-cost) 1)))

  (:action a-bad-4-11-1
    :parameters ()
    :precondition (and (at bad-3-3-2))
    :effect (and (not (at bad-3-3-2)) (at bad-4-11-1) (increase (total-cost) 1)))

  (:action a-bad-4-11-2
    :parameters ()
    :precondition (and (at bad-3-3-2))
    :effect (and (not (at bad-3-3-2)) (at bad-4-11-2) (increase (total-cost) 1)))

  (:action a-bad-4-12-0
    :parameters ()
    :precondition (and (at bad-3-4-0))
    :effect (and (not (at bad-3-4-0)) (at bad-4-12-0) (increase (total-cost) 1)))

  (:action a-bad-4-12-1
    :parameters ()
    :precondition (and (at bad-3-4-0))
    :effect (and (not (at bad-3-4-0)) (at bad-4-12-1) (increase (total-cost) 1)))

  (:action a-bad-4-12-2
    :parameters ()
    :precondition (and (at bad-3-4-0))
    :effect (and (not (at bad-3-4-0)) (at bad-4-12-2) (increase (total-cost) 1)))

  (:action a-bad-4-13-0
    :parameters ()
    :precondition (and (at bad-3-4-1))
    :effect (and (not (at bad-3-4-1)) (at bad-4-13-0) (increase (total-cost) 1)))

  (:action a-bad-4-13-1
    :parameters ()
    :precondition (and (at bad-3-4-1))
    :effect (and (not (at bad-3-4-1)) (at bad-4-13-1) (increase (total-cost) 1)))

  (:action a-bad-4-13-2
    :parameters ()
    :precondition (and (at bad-3-4-1))
    :effect (and (not (at bad-3-4-1)) (at bad-4-13-2) (increase (total-cost) 1)))

  (:action a-bad-4-14-0
    :parameters ()
    :precondition (and (at bad-3-4-2))
    :effect (and (not (at bad-3-4-2)) (at bad-4-14-0) (increase (total-cost) 1)))

  (:action a-bad-4-14-1
    :parameters ()
    :precondition (and (at bad-3-4-2))
    :effect (and (not (at bad-3-4-2)) (at bad-4-14-1) (increase (total-cost) 1)))

  (:action a-bad-4-14-2
    :parameters ()
    :precondition (and (at bad-3-4-2))
    :effect (and (not (at bad-3-4-2)) (at bad-4-14-2) (increase (total-cost) 1)))

  (:action a-bad-4-15-0
    :parameters ()
    :precondition (and (at bad-3-5-0))
    :effect (and (not (at bad-3-5-0)) (at bad-4-15-0) (increase (total-cost) 1)))

  (:action a-bad-4-15-1
    :parameters ()
    :precondition (and (at bad-3-5-0))
    :effect (and (not (at bad-3-5-0)) (at bad-4-15-1) (increase (total-cost) 1)))

  (:action a-bad-4-15-2
    :parameters ()
    :precondition (and (at bad-3-5-0))
    :effect (and (not (at bad-3-5-0)) (at bad-4-15-2) (increase (total-cost) 1)))

  (:action a-bad-4-16-0
    :parameters ()
    :precondition (and (at bad-3-5-1))
    :effect (and (not (at bad-3-5-1)) (at bad-4-16-0) (increase (total-cost) 1)))

  (:action a-bad-4-16-1
    :parameters ()
    :precondition (and (at bad-3-5-1))
    :effect (and (not (at bad-3-5-1)) (at bad-4-16-1) (increase (total-cost) 1)))

  (:action a-bad-4-16-2
    :parameters ()
    :precondition (and (at bad-3-5-1))
    :effect (and (not (at bad-3-5-1)) (at bad-4-16-2) (increase (total-cost) 1)))

  (:action a-bad-4-17-0
    :parameters ()
    :precondition (and (at bad-3-5-2))
    :effect (and (not (at bad-3-5-2)) (at bad-4-17-0) (increase (total-cost) 1)))

  (:action a-bad-4-17-1
    :parameters ()
    :precondition (and (at bad-3-5-2))
    :effect (and (not (at bad-3-5-2)) (at bad-4-17-1) (increase (total-cost) 1)))

  (:action a-bad-4-17-2
    :parameters ()
    :precondition (and (at bad-3-5-2))
    :effect (and (not (at bad-3-5-2)) (at bad-4-17-2) (increase (total-cost) 1)))

  (:action a-bad-4-18-0
    :parameters ()
    :precondition (and (at bad-3-6-0))
    :effect (and (not (at bad-3-6-0)) (at bad-4-18-0) (increase (total-cost) 1)))

  (:action a-bad-4-18-1
    :parameters ()
    :precondition (and (at bad-3-6-0))
    :effect (and (not (at bad-3-6-0)) (at bad-4-18-1) (increase (total-cost) 1)))

  (:action a-bad-4-18-2
    :parameters ()
    :precondition (and (at bad-3-6-0))
    :effect (and (not (at bad-3-6-0)) (at bad-4-18-2) (increase (total-cost) 1)))

  (:action a-bad-4-19-0
    :parameters ()
    :precondition (and (at bad-3-6-1))
    :effect (and (not (at bad-3-6-1)) (at bad-4-19-0) (increase (total-cost) 1)))

  (:action a-bad-4-19-1
    :parameters ()
    :precondition (and (at bad-3-6-1))
    :effect (and (not (at bad-3-6-1)) (at bad-4-19-1) (increase (total-cost) 1)))

  (:action a-bad-4-19-2
    :parameters ()
    :precondition (and (at bad-3-6-1))
    :effect (and (not (at bad-3-6-1)) (at bad-4-19-2) (increase (total-cost) 1)))

  (:action a-bad-4-20-0
    :parameters ()
    :precondition (and (at bad-3-6-2))
    :effect (and (not (at bad-3-6-2)) (at bad-4-20-0) (increase (total-cost) 1)))

  (:action a-bad-4-20-1
    :parameters ()
    :precondition (and (at bad-3-6-2))
    :effect (and (not (at bad-3-6-2)) (at bad-4-20-1) (increase (total-cost) 1)))

  (:action a-bad-4-20-2
    :parameters ()
    :precondition (and (at bad-3-6-2))
    :effect (and (not (at bad-3-6-2)) (at bad-4-20-2) (increase (total-cost) 1)))

  (:action a-bad-4-21-0
    :parameters ()
    :precondition (and (at bad-3-7-0))
    :effect (and (not (at bad-3-7-0)) (at bad-4-21-0) (increase (total-cost) 1)))

  (:action a-bad-4-21-1
    :parameters ()
    :precondition (and (at bad-3-7-0))
    :effect (and (not (at bad-3-7-0)) (at bad-4-21-1) (increase (total-cost) 1)))

  (:action a-bad-4-21-2
    :parameters ()
    :precondition (and (at bad-3-7-0))
    :effect (and (not (at bad-3-7-0)) (at bad-4-21-2) (increase (total-cost) 1)))

  (:action a-bad-4-22-0
    :parameters ()
    :precondition (and (at bad-3-7-1))
    :effect (and (not (at bad-3-7-1)) (at bad-4-22-0) (increase (total-cost) 1)))

  (:action a-bad-4-22-1
    :parameters ()
    :precondition (and (at bad-3-7-1))
    :effect (and (not (at bad-3-7-1)) (at bad-4-22-1) (increase (total-cost) 1)))

  (:action a-bad-4-22-2
    :parameters ()
    :precondition (and (at bad-3-7-1))
    :effect (and (not (at bad-3-7-1)) (at bad-4-22-2) (increase (total-cost) 1)))

  (:action a-bad-4-23-0
    :parameters ()
    :precondition (and (at bad-3-7-2))
    :effect (and (not (at bad-3-7-2)) (at bad-4-23-0) (increase (total-cost) 1)))

  (:action a-bad-4-23-1
    :parameters ()
    :precondition (and (at bad-3-7-2))
    :effect (and (not (at bad-3-7-2)) (at bad-4-23-1) (increase (total-cost) 1)))

  (:action a-bad-4-23-2
    :parameters ()
    :precondition (and (at bad-3-7-2))
    :effect (and (not (at bad-3-7-2)) (at bad-4-23-2) (increase (total-cost) 1)))

  (:action a-bad-4-24-0
    :parameters ()
    :precondition (and (at bad-3-8-0))
    :effect (and (not (at bad-3-8-0)) (at bad-4-24-0) (increase (total-cost) 1)))

  (:action a-bad-4-24-1
    :parameters ()
    :precondition (and (at bad-3-8-0))
    :effect (and (not (at bad-3-8-0)) (at bad-4-24-1) (increase (total-cost) 1)))

  (:action a-bad-4-24-2
    :parameters ()
    :precondition (and (at bad-3-8-0))
    :effect (and (not (at bad-3-8-0)) (at bad-4-24-2) (increase (total-cost) 1)))

  (:action a-bad-4-25-0
    :parameters ()
    :precondition (and (at bad-3-8-1))
    :effect (and (not (at bad-3-8-1)) (at bad-4-25-0) (increase (total-cost) 1)))

  (:action a-bad-4-25-1
    :parameters ()
    :precondition (and (at bad-3-8-1))
    :effect (and (not (at bad-3-8-1)) (at bad-4-25-1) (increase (total-cost) 1)))

  (:action a-bad-4-25-2
    :parameters ()
    :precondition (and (at bad-3-8-1))
    :effect (and (not (at bad-3-8-1)) (at bad-4-25-2) (increase (total-cost) 1)))

  (:action a-bad-4-26-0
    :parameters ()
    :precondition (and (at bad-3-8-2))
    :effect (and (not (at bad-3-8-2)) (at bad-4-26-0) (increase (total-cost) 1)))

  (:action a-bad-4-26-1
    :parameters ()
    :precondition (and (at bad-3-8-2))
    :effect (and (not (at bad-3-8-2)) (at bad-4-26-1) (increase (total-cost) 1)))

  (:action a-bad-4-26-2
    :parameters ()
    :precondition (and (at bad-3-8-2))
    :effect (and (not (at bad-3-8-2)) (at bad-4-26-2) (increase (total-cost) 1)))

  (:action a-bad-5-0-0
    :parameters ()
    :precondition (and (at bad-4-0-0))
    :effect (and (not (at bad-4-0-0)) (at bad-5-0-0) (increase (total-cost) 1)))

  (:action a-bad-5-0-1
    :parameters ()
    :precondition (and (at bad-4-0-0))
    :effect (and (not (at bad-4-0-0)) (at bad-5-0-1) (increase (total-cost) 1)))

  (:action a-bad-5-0-2
    :parameters ()
    :precondition (and (at bad-4-0-0))
    :effect (and (not (at bad-4-0-0)) (at bad-5-0-2) (increase (total-cost) 1)))

  (:action a-bad-5-1-0
    :parameters ()
    :precondition (and (at bad-4-0-1))
    :effect (and (not (at bad-4-0-1)) (at bad-5-1-0) (increase (total-cost) 1)))

  (:action a-bad-5-1-1
    :parameters ()
    :precondition (and (at bad-4-0-1))
    :effect (and (not (at bad-4-0-1)) (at bad-5-1-1) (increase (total-cost) 1)))

  (:action a-bad-5-1-2
    :parameters ()
    :precondition (and (at bad-4-0-1))
    :effect (and (not (at bad-4-0-1)) (at bad-5-1-2) (increase (total-cost) 1)))

  (:action a-bad-5-2-0
    :parameters ()
    :precondition (and (at bad-4-0-2))
    :effect (and (not (at bad-4-0-2)) (at bad-5-2-0) (increase (total-cost) 1)))

  (:action a-bad-5-2-1
    :parameters ()
    :precondition (and (at bad-4-0-2))
    :effect (and (not (at bad-4-0-2)) (at bad-5-2-1) (increase (total-cost) 1)))

  (:action a-bad-5-2-2
    :parameters ()
    :precondition (and (at bad-4-0-2))
    :effect (and (not (at bad-4-0-2)) (at bad-5-2-2) (increase (total-cost) 1)))

  (:action a-bad-5-3-0
    :parameters ()
    :precondition (and (at bad-4-1-0))
    :effect (and (not (at bad-4-1-0)) (at bad-5-3-0) (increase (total-cost) 1)))

  (:action a-bad-5-3-1
    :parameters ()
    :precondition (and (at bad-4-1-0))
    :effect (and (not (at bad-4-1-0)) (at bad-5-3-1) (increase (total-cost) 1)))

  (:action a-bad-5-3-2
    :parameters ()
    :precondition (and (at bad-4-1-0))
    :effect (and (not (at bad-4-1-0)) (at bad-5-3-2) (increase (total-cost) 1)))

  (:action a-bad-5-4-0
    :parameters ()
    :precondition (and (at bad-4-1-1))
    :effect (and (not (at bad-4-1-1)) (at bad-5-4-0) (increase (total-cost) 1)))

  (:action a-bad-5-4-1
    :parameters ()
    :precondition (and (at bad-4-1-1))
    :effect (and (not (at bad-4-1-1)) (at bad-5-4-1) (increase (total-cost) 1)))

  (:action a-bad-5-4-2
    :parameters ()
    :precondition (and (at bad-4-1-1))
    :effect (and (not (at bad-4-1-1)) (at bad-5-4-2) (increase (total-cost) 1)))

  (:action a-bad-5-5-0
    :parameters ()
    :precondition (and (at bad-4-1-2))
    :effect (and (not (at bad-4-1-2)) (at bad-5-5-0) (increase (total-cost) 1)))

  (:action a-bad-5-5-1
    :parameters ()
    :precondition (and (at bad-4-1-2))
    :effect (and (not (at bad-4-1-2)) (at bad-5-5-1) (increase (total-cost) 1)))

  (:action a-bad-5-5-2
    :parameters ()
    :precondition (and (at bad-4-1-2))
    :effect (and (not (at bad-4-1-2)) (at bad-5-5-2) (increase (total-cost) 1)))

  (:action a-bad-5-6-0
    :parameters ()
    :precondition (and (at bad-4-2-0))
    :effect (and (not (at bad-4-2-0)) (at bad-5-6-0) (increase (total-cost) 1)))

  (:action a-bad-5-6-1
    :parameters ()
    :precondition (and (at bad-4-2-0))
    :effect (and (not (at bad-4-2-0)) (at bad-5-6-1) (increase (total-cost) 1)))

  (:action a-bad-5-6-2
    :parameters ()
    :precondition (and (at bad-4-2-0))
    :effect (and (not (at bad-4-2-0)) (at bad-5-6-2) (increase (total-cost) 1)))

  (:action a-bad-5-7-0
    :parameters ()
    :precondition (and (at bad-4-2-1))
    :effect (and (not (at bad-4-2-1)) (at bad-5-7-0) (increase (total-cost) 1)))

  (:action a-bad-5-7-1
    :parameters ()
    :precondition (and (at bad-4-2-1))
    :effect (and (not (at bad-4-2-1)) (at bad-5-7-1) (increase (total-cost) 1)))

  (:action a-bad-5-7-2
    :parameters ()
    :precondition (and (at bad-4-2-1))
    :effect (and (not (at bad-4-2-1)) (at bad-5-7-2) (increase (total-cost) 1)))

  (:action a-bad-5-8-0
    :parameters ()
    :precondition (and (at bad-4-2-2))
    :effect (and (not (at bad-4-2-2)) (at bad-5-8-0) (increase (total-cost) 1)))

  (:action a-bad-5-8-1
    :parameters ()
    :precondition (and (at bad-4-2-2))
    :effect (and (not (at bad-4-2-2)) (at bad-5-8-1) (increase (total-cost) 1)))

  (:action a-bad-5-8-2
    :parameters ()
    :precondition (and (at bad-4-2-2))
    :effect (and (not (at bad-4-2-2)) (at bad-5-8-2) (increase (total-cost) 1)))

  (:action a-bad-5-9-0
    :parameters ()
    :precondition (and (at bad-4-3-0))
    :effect (and (not (at bad-4-3-0)) (at bad-5-9-0) (increase (total-cost) 1)))

  (:action a-bad-5-9-1
    :parameters ()
    :precondition (and (at bad-4-3-0))
    :effect (and (not (at bad-4-3-0)) (at bad-5-9-1) (increase (total-cost) 1)))

  (:action a-bad-5-9-2
    :parameters ()
    :precondition (and (at bad-4-3-0))
    :effect (and (not (at bad-4-3-0)) (at bad-5-9-2) (increase (total-cost) 1)))

  (:action a-bad-5-10-0
    :parameters ()
    :precondition (and (at bad-4-3-1))
    :effect (and (not (at bad-4-3-1)) (at bad-5-10-0) (increase (total-cost) 1)))

  (:action a-bad-5-10-1
    :parameters ()
    :precondition (and (at bad-4-3-1))
    :effect (and (not (at bad-4-3-1)) (at bad-5-10-1) (increase (total-cost) 1)))

  (:action a-bad-5-10-2
    :parameters ()
    :precondition (and (at bad-4-3-1))
    :effect (and (not (at bad-4-3-1)) (at bad-5-10-2) (increase (total-cost) 1)))

  (:action a-bad-5-11-0
    :parameters ()
    :precondition (and (at bad-4-3-2))
    :effect (and (not (at bad-4-3-2)) (at bad-5-11-0) (increase (total-cost) 1)))

  (:action a-bad-5-11-1
    :parameters ()
    :precondition (and (at bad-4-3-2))
    :effect (and (not (at bad-4-3-2)) (at bad-5-11-1) (increase (total-cost) 1)))

  (:action a-bad-5-11-2
    :parameters ()
    :precondition (and (at bad-4-3-2))
    :effect (and (not (at bad-4-3-2)) (at bad-5-11-2) (increase (total-cost) 1)))

  (:action a-bad-5-12-0
    :parameters ()
    :precondition (and (at bad-4-4-0))
    :effect (and (not (at bad-4-4-0)) (at bad-5-12-0) (increase (total-cost) 1)))

  (:action a-bad-5-12-1
    :parameters ()
    :precondition (and (at bad-4-4-0))
    :effect (and (not (at bad-4-4-0)) (at bad-5-12-1) (increase (total-cost) 1)))

  (:action a-bad-5-12-2
    :parameters ()
    :precondition (and (at bad-4-4-0))
    :effect (and (not (at bad-4-4-0)) (at bad-5-12-2) (increase (total-cost) 1)))

  (:action a-bad-5-13-0
    :parameters ()
    :precondition (and (at bad-4-4-1))
    :effect (and (not (at bad-4-4-1)) (at bad-5-13-0) (increase (total-cost) 1)))

  (:action a-bad-5-13-1
    :parameters ()
    :precondition (and (at bad-4-4-1))
    :effect (and (not (at bad-4-4-1)) (at bad-5-13-1) (increase (total-cost) 1)))

  (:action a-bad-5-13-2
    :parameters ()
    :precondition (and (at bad-4-4-1))
    :effect (and (not (at bad-4-4-1)) (at bad-5-13-2) (increase (total-cost) 1)))

  (:action a-bad-5-14-0
    :parameters ()
    :precondition (and (at bad-4-4-2))
    :effect (and (not (at bad-4-4-2)) (at bad-5-14-0) (increase (total-cost) 1)))

  (:action a-bad-5-14-1
    :parameters ()
    :precondition (and (at bad-4-4-2))
    :effect (and (not (at bad-4-4-2)) (at bad-5-14-1) (increase (total-cost) 1)))

  (:action a-bad-5-14-2
    :parameters ()
    :precondition (and (at bad-4-4-2))
    :effect (and (not (at bad-4-4-2)) (at bad-5-14-2) (increase (total-cost) 1)))

  (:action a-bad-5-15-0
    :parameters ()
    :precondition (and (at bad-4-5-0))
    :effect (and (not (at bad-4-5-0)) (at bad-5-15-0) (increase (total-cost) 1)))

  (:action a-bad-5-15-1
    :parameters ()
    :precondition (and (at bad-4-5-0))
    :effect (and (not (at bad-4-5-0)) (at bad-5-15-1) (increase (total-cost) 1)))

  (:action a-bad-5-15-2
    :parameters ()
    :precondition (and (at bad-4-5-0))
    :effect (and (not (at bad-4-5-0)) (at bad-5-15-2) (increase (total-cost) 1)))

  (:action a-bad-5-16-0
    :parameters ()
    :precondition (and (at bad-4-5-1))
    :effect (and (not (at bad-4-5-1)) (at bad-5-16-0) (increase (total-cost) 1)))

  (:action a-bad-5-16-1
    :parameters ()
    :precondition (and (at bad-4-5-1))
    :effect (and (not (at bad-4-5-1)) (at bad-5-16-1) (increase (total-cost) 1)))

  (:action a-bad-5-16-2
    :parameters ()
    :precondition (and (at bad-4-5-1))
    :effect (and (not (at bad-4-5-1)) (at bad-5-16-2) (increase (total-cost) 1)))

  (:action a-bad-5-17-0
    :parameters ()
    :precondition (and (at bad-4-5-2))
    :effect (and (not (at bad-4-5-2)) (at bad-5-17-0) (increase (total-cost) 1)))

  (:action a-bad-5-17-1
    :parameters ()
    :precondition (and (at bad-4-5-2))
    :effect (and (not (at bad-4-5-2)) (at bad-5-17-1) (increase (total-cost) 1)))

  (:action a-bad-5-17-2
    :parameters ()
    :precondition (and (at bad-4-5-2))
    :effect (and (not (at bad-4-5-2)) (at bad-5-17-2) (increase (total-cost) 1)))

  (:action a-bad-5-18-0
    :parameters ()
    :precondition (and (at bad-4-6-0))
    :effect (and (not (at bad-4-6-0)) (at bad-5-18-0) (increase (total-cost) 1)))

  (:action a-bad-5-18-1
    :parameters ()
    :precondition (and (at bad-4-6-0))
    :effect (and (not (at bad-4-6-0)) (at bad-5-18-1) (increase (total-cost) 1)))

  (:action a-bad-5-18-2
    :parameters ()
    :precondition (and (at bad-4-6-0))
    :effect (and (not (at bad-4-6-0)) (at bad-5-18-2) (increase (total-cost) 1)))

  (:action a-bad-5-19-0
    :parameters ()
    :precondition (and (at bad-4-6-1))
    :effect (and (not (at bad-4-6-1)) (at bad-5-19-0) (increase (total-cost) 1)))

  (:action a-bad-5-19-1
    :parameters ()
    :precondition (and (at bad-4-6-1))
    :effect (and (not (at bad-4-6-1)) (at bad-5-19-1) (increase (total-cost) 1)))

  (:action a-bad-5-19-2
    :parameters ()
    :precondition (and (at bad-4-6-1))
    :effect (and (not (at bad-4-6-1)) (at bad-5-19-2) (increase (total-cost) 1)))

  (:action a-bad-5-20-0
    :parameters ()
    :precondition (and (at bad-4-6-2))
    :effect (and (not (at bad-4-6-2)) (at bad-5-20-0) (increase (total-cost) 1)))

  (:action a-bad-5-20-1
    :parameters ()
    :precondition (and (at bad-4-6-2))
    :effect (and (not (at bad-4-6-2)) (at bad-5-20-1) (increase (total-cost) 1)))

  (:action a-bad-5-20-2
    :parameters ()
    :precondition (and (at bad-4-6-2))
    :effect (and (not (at bad-4-6-2)) (at bad-5-20-2) (increase (total-cost) 1)))

  (:action a-bad-5-21-0
    :parameters ()
    :precondition (and (at bad-4-7-0))
    :effect (and (not (at bad-4-7-0)) (at bad-5-21-0) (increase (total-cost) 1)))

  (:action a-bad-5-21-1
    :parameters ()
    :precondition (and (at bad-4-7-0))
    :effect (and (not (at bad-4-7-0)) (at bad-5-21-1) (increase (total-cost) 1)))

  (:action a-bad-5-21-2
    :parameters ()
    :precondition (and (at bad-4-7-0))
    :effect (and (not (at bad-4-7-0)) (at bad-5-21-2) (increase (total-cost) 1)))

  (:action a-bad-5-22-0
    :parameters ()
    :precondition (and (at bad-4-7-1))
    :effect (and (not (at bad-4-7-1)) (at bad-5-22-0) (increase (total-cost) 1)))

  (:action a-bad-5-22-1
    :parameters ()
    :precondition (and (at bad-4-7-1))
    :effect (and (not (at bad-4-7-1)) (at bad-5-22-1) (increase (total-cost) 1)))

  (:action a-bad-5-22-2
    :parameters ()
    :precondition (and (at bad-4-7-1))
    :effect (and (not (at bad-4-7-1)) (at bad-5-22-2) (increase (total-cost) 1)))

  (:action a-bad-5-23-0
    :parameters ()
    :precondition (and (at bad-4-7-2))
    :effect (and (not (at bad-4-7-2)) (at bad-5-23-0) (increase (total-cost) 1)))

  (:action a-bad-5-23-1
    :parameters ()
    :precondition (and (at bad-4-7-2))
    :effect (and (not (at bad-4-7-2)) (at bad-5-23-1) (increase (total-cost) 1)))

  (:action a-bad-5-23-2
    :parameters ()
    :precondition (and (at bad-4-7-2))
    :effect (and (not (at bad-4-7-2)) (at bad-5-23-2) (increase (total-cost) 1)))

  (:action a-bad-5-24-0
    :parameters ()
    :precondition (and (at bad-4-8-0))
    :effect (and (not (at bad-4-8-0)) (at bad-5-24-0) (increase (total-cost) 1)))

  (:action a-bad-5-24-1
    :parameters ()
    :precondition (and (at bad-4-8-0))
    :effect (and (not (at bad-4-8-0)) (at bad-5-24-1) (increase (total-cost) 1)))

  (:action a-bad-5-24-2
    :parameters ()
    :precondition (and (at bad-4-8-0))
    :effect (and (not (at bad-4-8-0)) (at bad-5-24-2) (increase (total-cost) 1)))

  (:action a-bad-5-25-0
    :parameters ()
    :precondition (and (at bad-4-8-1))
    :effect (and (not (at bad-4-8-1)) (at bad-5-25-0) (increase (total-cost) 1)))

  (:action a-bad-5-25-1
    :parameters ()
    :precondition (and (at bad-4-8-1))
    :effect (and (not (at bad-4-8-1)) (at bad-5-25-1) (increase (total-cost) 1)))

  (:action a-bad-5-25-2
    :parameters ()
    :precondition (and (at bad-4-8-1))
    :effect (and (not (at bad-4-8-1)) (at bad-5-25-2) (increase (total-cost) 1)))

  (:action a-bad-5-26-0
    :parameters ()
    :precondition (and (at bad-4-8-2))
    :effect (and (not (at bad-4-8-2)) (at bad-5-26-0) (increase (total-cost) 1)))

  (:action a-bad-5-26-1
    :parameters ()
    :precondition (and (at bad-4-8-2))
    :effect (and (not (at bad-4-8-2)) (at bad-5-26-1) (increase (total-cost) 1)))

  (:action a-bad-5-26-2
    :parameters ()
    :precondition (and (at bad-4-8-2))
    :effect (and (not (at bad-4-8-2)) (at bad-5-26-2) (increase (total-cost) 1)))

  (:action a-bad-5-27-0
    :parameters ()
    :precondition (and (at bad-4-9-0))
    :effect (and (not (at bad-4-9-0)) (at bad-5-27-0) (increase (total-cost) 1)))

  (:action a-bad-5-27-1
    :parameters ()
    :precondition (and (at bad-4-9-0))
    :effect (and (not (at bad-4-9-0)) (at bad-5-27-1) (increase (total-cost) 1)))

  (:action a-bad-5-27-2
    :parameters ()
    :precondition (and (at bad-4-9-0))
    :effect (and (not (at bad-4-9-0)) (at bad-5-27-2) (increase (total-cost) 1)))

  (:action a-bad-5-28-0
    :parameters ()
    :precondition (and (at bad-4-9-1))
    :effect (and (not (at bad-4-9-1)) (at bad-5-28-0) (increase (total-cost) 1)))

  (:action a-bad-5-28-1
    :parameters ()
    :precondition (and (at bad-4-9-1))
    :effect (and (not (at bad-4-9-1)) (at bad-5-28-1) (increase (total-cost) 1)))

  (:action a-bad-5-28-2
    :parameters ()
    :precondition (and (at bad-4-9-1))
    :effect (and (not (at bad-4-9-1)) (at bad-5-28-2) (increase (total-cost) 1)))

  (:action a-bad-5-29-0
    :parameters ()
    :precondition (and (at bad-4-9-2))
    :effect (and (not (at bad-4-9-2)) (at bad-5-29-0) (increase (total-cost) 1)))

  (:action a-bad-5-29-1
    :parameters ()
    :precondition (and (at bad-4-9-2))
    :effect (and (not (at bad-4-9-2)) (at bad-5-29-1) (increase (total-cost) 1)))

  (:action a-bad-5-29-2
    :parameters ()
    :precondition (and (at bad-4-9-2))
    :effect (and (not (at bad-4-9-2)) (at bad-5-29-2) (increase (total-cost) 1)))

  (:action a-bad-5-30-0
    :parameters ()
    :precondition (and (at bad-4-10-0))
    :effect (and (not (at bad-4-10-0)) (at bad-5-30-0) (increase (total-cost) 1)))

  (:action a-bad-5-30-1
    :parameters ()
    :precondition (and (at bad-4-10-0))
    :effect (and (not (at bad-4-10-0)) (at bad-5-30-1) (increase (total-cost) 1)))

  (:action a-bad-5-30-2
    :parameters ()
    :precondition (and (at bad-4-10-0))
    :effect (and (not (at bad-4-10-0)) (at bad-5-30-2) (increase (total-cost) 1)))

  (:action a-bad-5-31-0
    :parameters ()
    :precondition (and (at bad-4-10-1))
    :effect (and (not (at bad-4-10-1)) (at bad-5-31-0) (increase (total-cost) 1)))

  (:action a-bad-5-31-1
    :parameters ()
    :precondition (and (at bad-4-10-1))
    :effect (and (not (at bad-4-10-1)) (at bad-5-31-1) (increase (total-cost) 1)))

  (:action a-bad-5-31-2
    :parameters ()
    :precondition (and (at bad-4-10-1))
    :effect (and (not (at bad-4-10-1)) (at bad-5-31-2) (increase (total-cost) 1)))

  (:action a-bad-5-32-0
    :parameters ()
    :precondition (and (at bad-4-10-2))
    :effect (and (not (at bad-4-10-2)) (at bad-5-32-0) (increase (total-cost) 1)))

  (:action a-bad-5-32-1
    :parameters ()
    :precondition (and (at bad-4-10-2))
    :effect (and (not (at bad-4-10-2)) (at bad-5-32-1) (increase (total-cost) 1)))

  (:action a-bad-5-32-2
    :parameters ()
    :precondition (and (at bad-4-10-2))
    :effect (and (not (at bad-4-10-2)) (at bad-5-32-2) (increase (total-cost) 1)))

  (:action a-bad-5-33-0
    :parameters ()
    :precondition (and (at bad-4-11-0))
    :effect (and (not (at bad-4-11-0)) (at bad-5-33-0) (increase (total-cost) 1)))

  (:action a-bad-5-33-1
    :parameters ()
    :precondition (and (at bad-4-11-0))
    :effect (and (not (at bad-4-11-0)) (at bad-5-33-1) (increase (total-cost) 1)))

  (:action a-bad-5-33-2
    :parameters ()
    :precondition (and (at bad-4-11-0))
    :effect (and (not (at bad-4-11-0)) (at bad-5-33-2) (increase (total-cost) 1)))

  (:action a-bad-5-34-0
    :parameters ()
    :precondition (and (at bad-4-11-1))
    :effect (and (not (at bad-4-11-1)) (at bad-5-34-0) (increase (total-cost) 1)))

  (:action a-bad-5-34-1
    :parameters ()
    :precondition (and (at bad-4-11-1))
    :effect (and (not (at bad-4-11-1)) (at bad-5-34-1) (increase (total-cost) 1)))

  (:action a-bad-5-34-2
    :parameters ()
    :precondition (and (at bad-4-11-1))
    :effect (and (not (at bad-4-11-1)) (at bad-5-34-2) (increase (total-cost) 1)))

  (:action a-bad-5-35-0
    :parameters ()
    :precondition (and (at bad-4-11-2))
    :effect (and (not (at bad-4-11-2)) (at bad-5-35-0) (increase (total-cost) 1)))

  (:action a-bad-5-35-1
    :parameters ()
    :precondition (and (at bad-4-11-2))
    :effect (and (not (at bad-4-11-2)) (at bad-5-35-1) (increase (total-cost) 1)))

  (:action a-bad-5-35-2
    :parameters ()
    :precondition (and (at bad-4-11-2))
    :effect (and (not (at bad-4-11-2)) (at bad-5-35-2) (increase (total-cost) 1)))

  (:action a-bad-5-36-0
    :parameters ()
    :precondition (and (at bad-4-12-0))
    :effect (and (not (at bad-4-12-0)) (at bad-5-36-0) (increase (total-cost) 1)))

  (:action a-bad-5-36-1
    :parameters ()
    :precondition (and (at bad-4-12-0))
    :effect (and (not (at bad-4-12-0)) (at bad-5-36-1) (increase (total-cost) 1)))

  (:action a-bad-5-36-2
    :parameters ()
    :precondition (and (at bad-4-12-0))
    :effect (and (not (at bad-4-12-0)) (at bad-5-36-2) (increase (total-cost) 1)))

  (:action a-bad-5-37-0
    :parameters ()
    :precondition (and (at bad-4-12-1))
    :effect (and (not (at bad-4-12-1)) (at bad-5-37-0) (increase (total-cost) 1)))

  (:action a-bad-5-37-1
    :parameters ()
    :precondition (and (at bad-4-12-1))
    :effect (and (not (at bad-4-12-1)) (at bad-5-37-1) (increase (total-cost) 1)))

  (:action a-bad-5-37-2
    :parameters ()
    :precondition (and (at bad-4-12-1))
    :effect (and (not (at bad-4-12-1)) (at bad-5-37-2) (increase (total-cost) 1)))

  (:action a-bad-5-38-0
    :parameters ()
    :precondition (and (at bad-4-12-2))
    :effect (and (not (at bad-4-12-2)) (at bad-5-38-0) (increase (total-cost) 1)))

  (:action a-bad-5-38-1
    :parameters ()
    :precondition (and (at bad-4-12-2))
    :effect (and (not (at bad-4-12-2)) (at bad-5-38-1) (increase (total-cost) 1)))

  (:action a-bad-5-38-2
    :parameters ()
    :precondition (and (at bad-4-12-2))
    :effect (and (not (at bad-4-12-2)) (at bad-5-38-2) (increase (total-cost) 1)))

  (:action a-bad-5-39-0
    :parameters ()
    :precondition (and (at bad-4-13-0))
    :effect (and (not (at bad-4-13-0)) (at bad-5-39-0) (increase (total-cost) 1)))

  (:action a-bad-5-39-1
    :parameters ()
    :precondition (and (at bad-4-13-0))
    :effect (and (not (at bad-4-13-0)) (at bad-5-39-1) (increase (total-cost) 1)))

  (:action a-bad-5-39-2
    :parameters ()
    :precondition (and (at bad-4-13-0))
    :effect (and (not (at bad-4-13-0)) (at bad-5-39-2) (increase (total-cost) 1)))

  (:action a-bad-5-40-0
    :parameters ()
    :precondition (and (at bad-4-13-1))
    :effect (and (not (at bad-4-13-1)) (at bad-5-40-0) (increase (total-cost) 1)))

  (:action a-bad-5-40-1
    :parameters ()
    :precondition (and (at bad-4-13-1))
    :effect (and (not (at bad-4-13-1)) (at bad-5-40-1) (increase (total-cost) 1)))

  (:action a-bad-5-40-2
    :parameters ()
    :precondition (and (at bad-4-13-1))
    :effect (and (not (at bad-4-13-1)) (at bad-5-40-2) (increase (total-cost) 1)))

  (:action a-bad-5-41-0
    :parameters ()
    :precondition (and (at bad-4-13-2))
    :effect (and (not (at bad-4-13-2)) (at bad-5-41-0) (increase (total-cost) 1)))

  (:action a-bad-5-41-1
    :parameters ()
    :precondition (and (at bad-4-13-2))
    :effect (and (not (at bad-4-13-2)) (at bad-5-41-1) (increase (total-cost) 1)))

  (:action a-bad-5-41-2
    :parameters ()
    :precondition (and (at bad-4-13-2))
    :effect (and (not (at bad-4-13-2)) (at bad-5-41-2) (increase (total-cost) 1)))

  (:action a-bad-5-42-0
    :parameters ()
    :precondition (and (at bad-4-14-0))
    :effect (and (not (at bad-4-14-0)) (at bad-5-42-0) (increase (total-cost) 1)))

  (:action a-bad-5-42-1
    :parameters ()
    :precondition (and (at bad-4-14-0))
    :effect (and (not (at bad-4-14-0)) (at bad-5-42-1) (increase (total-cost) 1)))

  (:action a-bad-5-42-2
    :parameters ()
    :precondition (and (at bad-4-14-0))
    :effect (and (not (at bad-4-14-0)) (at bad-5-42-2) (increase (total-cost) 1)))

  (:action a-bad-5-43-0
    :parameters ()
    :precondition (and (at bad-4-14-1))
    :effect (and (not (at bad-4-14-1)) (at bad-5-43-0) (increase (total-cost) 1)))

  (:action a-bad-5-43-1
    :parameters ()
    :precondition (and (at bad-4-14-1))
    :effect (and (not (at bad-4-14-1)) (at bad-5-43-1) (increase (total-cost) 1)))

  (:action a-bad-5-43-2
    :parameters ()
    :precondition (and (at bad-4-14-1))
    :effect (and (not (at bad-4-14-1)) (at bad-5-43-2) (increase (total-cost) 1)))

  (:action a-bad-5-44-0
    :parameters ()
    :precondition (and (at bad-4-14-2))
    :effect (and (not (at bad-4-14-2)) (at bad-5-44-0) (increase (total-cost) 1)))

  (:action a-bad-5-44-1
    :parameters ()
    :precondition (and (at bad-4-14-2))
    :effect (and (not (at bad-4-14-2)) (at bad-5-44-1) (increase (total-cost) 1)))

  (:action a-bad-5-44-2
    :parameters ()
    :precondition (and (at bad-4-14-2))
    :effect (and (not (at bad-4-14-2)) (at bad-5-44-2) (increase (total-cost) 1)))

  (:action a-bad-5-45-0
    :parameters ()
    :precondition (and (at bad-4-15-0))
    :effect (and (not (at bad-4-15-0)) (at bad-5-45-0) (increase (total-cost) 1)))

  (:action a-bad-5-45-1
    :parameters ()
    :precondition (and (at bad-4-15-0))
    :effect (and (not (at bad-4-15-0)) (at bad-5-45-1) (increase (total-cost) 1)))

  (:action a-bad-5-45-2
    :parameters ()
    :precondition (and (at bad-4-15-0))
    :effect (and (not (at bad-4-15-0)) (at bad-5-45-2) (increase (total-cost) 1)))

  (:action a-bad-5-46-0
    :parameters ()
    :precondition (and (at bad-4-15-1))
    :effect (and (not (at bad-4-15-1)) (at bad-5-46-0) (increase (total-cost) 1)))

  (:action a-bad-5-46-1
    :parameters ()
    :precondition (and (at bad-4-15-1))
    :effect (and (not (at bad-4-15-1)) (at bad-5-46-1) (increase (total-cost) 1)))

  (:action a-bad-5-46-2
    :parameters ()
    :precondition (and (at bad-4-15-1))
    :effect (and (not (at bad-4-15-1)) (at bad-5-46-2) (increase (total-cost) 1)))

  (:action a-bad-5-47-0
    :parameters ()
    :precondition (and (at bad-4-15-2))
    :effect (and (not (at bad-4-15-2)) (at bad-5-47-0) (increase (total-cost) 1)))

  (:action a-bad-5-47-1
    :parameters ()
    :precondition (and (at bad-4-15-2))
    :effect (and (not (at bad-4-15-2)) (at bad-5-47-1) (increase (total-cost) 1)))

  (:action a-bad-5-47-2
    :parameters ()
    :precondition (and (at bad-4-15-2))
    :effect (and (not (at bad-4-15-2)) (at bad-5-47-2) (increase (total-cost) 1)))

  (:action a-bad-5-48-0
    :parameters ()
    :precondition (and (at bad-4-16-0))
    :effect (and (not (at bad-4-16-0)) (at bad-5-48-0) (increase (total-cost) 1)))

  (:action a-bad-5-48-1
    :parameters ()
    :precondition (and (at bad-4-16-0))
    :effect (and (not (at bad-4-16-0)) (at bad-5-48-1) (increase (total-cost) 1)))

  (:action a-bad-5-48-2
    :parameters ()
    :precondition (and (at bad-4-16-0))
    :effect (and (not (at bad-4-16-0)) (at bad-5-48-2) (increase (total-cost) 1)))

  (:action a-bad-5-49-0
    :parameters ()
    :precondition (and (at bad-4-16-1))
    :effect (and (not (at bad-4-16-1)) (at bad-5-49-0) (increase (total-cost) 1)))

  (:action a-bad-5-49-1
    :parameters ()
    :precondition (and (at bad-4-16-1))
    :effect (and (not (at bad-4-16-1)) (at bad-5-49-1) (increase (total-cost) 1)))

  (:action a-bad-5-49-2
    :parameters ()
    :precondition (and (at bad-4-16-1))
    :effect (and (not (at bad-4-16-1)) (at bad-5-49-2) (increase (total-cost) 1)))

  (:action a-bad-5-50-0
    :parameters ()
    :precondition (and (at bad-4-16-2))
    :effect (and (not (at bad-4-16-2)) (at bad-5-50-0) (increase (total-cost) 1)))

  (:action a-bad-5-50-1
    :parameters ()
    :precondition (and (at bad-4-16-2))
    :effect (and (not (at bad-4-16-2)) (at bad-5-50-1) (increase (total-cost) 1)))

  (:action a-bad-5-50-2
    :parameters ()
    :precondition (and (at bad-4-16-2))
    :effect (and (not (at bad-4-16-2)) (at bad-5-50-2) (increase (total-cost) 1)))

  (:action a-bad-5-51-0
    :parameters ()
    :precondition (and (at bad-4-17-0))
    :effect (and (not (at bad-4-17-0)) (at bad-5-51-0) (increase (total-cost) 1)))

  (:action a-bad-5-51-1
    :parameters ()
    :precondition (and (at bad-4-17-0))
    :effect (and (not (at bad-4-17-0)) (at bad-5-51-1) (increase (total-cost) 1)))

  (:action a-bad-5-51-2
    :parameters ()
    :precondition (and (at bad-4-17-0))
    :effect (and (not (at bad-4-17-0)) (at bad-5-51-2) (increase (total-cost) 1)))

  (:action a-bad-5-52-0
    :parameters ()
    :precondition (and (at bad-4-17-1))
    :effect (and (not (at bad-4-17-1)) (at bad-5-52-0) (increase (total-cost) 1)))

  (:action a-bad-5-52-1
    :parameters ()
    :precondition (and (at bad-4-17-1))
    :effect (and (not (at bad-4-17-1)) (at bad-5-52-1) (increase (total-cost) 1)))

  (:action a-bad-5-52-2
    :parameters ()
    :precondition (and (at bad-4-17-1))
    :effect (and (not (at bad-4-17-1)) (at bad-5-52-2) (increase (total-cost) 1)))

  (:action a-bad-5-53-0
    :parameters ()
    :precondition (and (at bad-4-17-2))
    :effect (and (not (at bad-4-17-2)) (at bad-5-53-0) (increase (total-cost) 1)))

  (:action a-bad-5-53-1
    :parameters ()
    :precondition (and (at bad-4-17-2))
    :effect (and (not (at bad-4-17-2)) (at bad-5-53-1) (increase (total-cost) 1)))

  (:action a-bad-5-53-2
    :parameters ()
    :precondition (and (at bad-4-17-2))
    :effect (and (not (at bad-4-17-2)) (at bad-5-53-2) (increase (total-cost) 1)))

  (:action a-bad-5-54-0
    :parameters ()
    :precondition (and (at bad-4-18-0))
    :effect (and (not (at bad-4-18-0)) (at bad-5-54-0) (increase (total-cost) 1)))

  (:action a-bad-5-54-1
    :parameters ()
    :precondition (and (at bad-4-18-0))
    :effect (and (not (at bad-4-18-0)) (at bad-5-54-1) (increase (total-cost) 1)))

  (:action a-bad-5-54-2
    :parameters ()
    :precondition (and (at bad-4-18-0))
    :effect (and (not (at bad-4-18-0)) (at bad-5-54-2) (increase (total-cost) 1)))

  (:action a-bad-5-55-0
    :parameters ()
    :precondition (and (at bad-4-18-1))
    :effect (and (not (at bad-4-18-1)) (at bad-5-55-0) (increase (total-cost) 1)))

  (:action a-bad-5-55-1
    :parameters ()
    :precondition (and (at bad-4-18-1))
    :effect (and (not (at bad-4-18-1)) (at bad-5-55-1) (increase (total-cost) 1)))

  (:action a-bad-5-55-2
    :parameters ()
    :precondition (and (at bad-4-18-1))
    :effect (and (not (at bad-4-18-1)) (at bad-5-55-2) (increase (total-cost) 1)))

  (:action a-bad-5-56-0
    :parameters ()
    :precondition (and (at bad-4-18-2))
    :effect (and (not (at bad-4-18-2)) (at bad-5-56-0) (increase (total-cost) 1)))

  (:action a-bad-5-56-1
    :parameters ()
    :precondition (and (at bad-4-18-2))
    :effect (and (not (at bad-4-18-2)) (at bad-5-56-1) (increase (total-cost) 1)))

  (:action a-bad-5-56-2
    :parameters ()
    :precondition (and (at bad-4-18-2))
    :effect (and (not (at bad-4-18-2)) (at bad-5-56-2) (increase (total-cost) 1)))

  (:action a-bad-5-57-0
    :parameters ()
    :precondition (and (at bad-4-19-0))
    :effect (and (not (at bad-4-19-0)) (at bad-5-57-0) (increase (total-cost) 1)))

  (:action a-bad-5-57-1
    :parameters ()
    :precondition (and (at bad-4-19-0))
    :effect (and (not (at bad-4-19-0)) (at bad-5-57-1) (increase (total-cost) 1)))

  (:action a-bad-5-57-2
    :parameters ()
    :precondition (and (at bad-4-19-0))
    :effect (and (not (at bad-4-19-0)) (at bad-5-57-2) (increase (total-cost) 1)))

  (:action a-bad-5-58-0
    :parameters ()
    :precondition (and (at bad-4-19-1))
    :effect (and (not (at bad-4-19-1)) (at bad-5-58-0) (increase (total-cost) 1)))

  (:action a-bad-5-58-1
    :parameters ()
    :precondition (and (at bad-4-19-1))
    :effect (and (not (at bad-4-19-1)) (at bad-5-58-1) (increase (total-cost) 1)))

  (:action a-bad-5-58-2
    :parameters ()
    :precondition (and (at bad-4-19-1))
    :effect (and (not (at bad-4-19-1)) (at bad-5-58-2) (increase (total-cost) 1)))

  (:action a-bad-5-59-0
    :parameters ()
    :precondition (and (at bad-4-19-2))
    :effect (and (not (at bad-4-19-2)) (at bad-5-59-0) (increase (total-cost) 1)))

  (:action a-bad-5-59-1
    :parameters ()
    :precondition (and (at bad-4-19-2))
    :effect (and (not (at bad-4-19-2)) (at bad-5-59-1) (increase (total-cost) 1)))

  (:action a-bad-5-59-2
    :parameters ()
    :precondition (and (at bad-4-19-2))
    :effect (and (not (at bad-4-19-2)) (at bad-5-59-2) (increase (total-cost) 1)))

  (:action a-bad-5-60-0
    :parameters ()
    :precondition (and (at bad-4-20-0))
    :effect (and (not (at bad-4-20-0)) (at bad-5-60-0) (increase (total-cost) 1)))

  (:action a-bad-5-60-1
    :parameters ()
    :precondition (and (at bad-4-20-0))
    :effect (and (not (at bad-4-20-0)) (at bad-5-60-1) (increase (total-cost) 1)))

  (:action a-bad-5-60-2
    :parameters ()
    :precondition (and (at bad-4-20-0))
    :effect (and (not (at bad-4-20-0)) (at bad-5-60-2) (increase (total-cost) 1)))

  (:action a-bad-5-61-0
    :parameters ()
    :precondition (and (at bad-4-20-1))
    :effect (and (not (at bad-4-20-1)) (at bad-5-61-0) (increase (total-cost) 1)))

  (:action a-bad-5-61-1
    :parameters ()
    :precondition (and (at bad-4-20-1))
    :effect (and (not (at bad-4-20-1)) (at bad-5-61-1) (increase (total-cost) 1)))

  (:action a-bad-5-61-2
    :parameters ()
    :precondition (and (at bad-4-20-1))
    :effect (and (not (at bad-4-20-1)) (at bad-5-61-2) (increase (total-cost) 1)))

  (:action a-bad-5-62-0
    :parameters ()
    :precondition (and (at bad-4-20-2))
    :effect (and (not (at bad-4-20-2)) (at bad-5-62-0) (increase (total-cost) 1)))

  (:action a-bad-5-62-1
    :parameters ()
    :precondition (and (at bad-4-20-2))
    :effect (and (not (at bad-4-20-2)) (at bad-5-62-1) (increase (total-cost) 1)))

  (:action a-bad-5-62-2
    :parameters ()
    :precondition (and (at bad-4-20-2))
    :effect (and (not (at bad-4-20-2)) (at bad-5-62-2) (increase (total-cost) 1)))

  (:action a-bad-5-63-0
    :parameters ()
    :precondition (and (at bad-4-21-0))
    :effect (and (not (at bad-4-21-0)) (at bad-5-63-0) (increase (total-cost) 1)))

  (:action a-bad-5-63-1
    :parameters ()
    :precondition (and (at bad-4-21-0))
    :effect (and (not (at bad-4-21-0)) (at bad-5-63-1) (increase (total-cost) 1)))

  (:action a-bad-5-63-2
    :parameters ()
    :precondition (and (at bad-4-21-0))
    :effect (and (not (at bad-4-21-0)) (at bad-5-63-2) (increase (total-cost) 1)))

  (:action a-bad-5-64-0
    :parameters ()
    :precondition (and (at bad-4-21-1))
    :effect (and (not (at bad-4-21-1)) (at bad-5-64-0) (increase (total-cost) 1)))

  (:action a-bad-5-64-1
    :parameters ()
    :precondition (and (at bad-4-21-1))
    :effect (and (not (at bad-4-21-1)) (at bad-5-64-1) (increase (total-cost) 1)))

  (:action a-bad-5-64-2
    :parameters ()
    :precondition (and (at bad-4-21-1))
    :effect (and (not (at bad-4-21-1)) (at bad-5-64-2) (increase (total-cost) 1)))

  (:action a-bad-5-65-0
    :parameters ()
    :precondition (and (at bad-4-21-2))
    :effect (and (not (at bad-4-21-2)) (at bad-5-65-0) (increase (total-cost) 1)))

  (:action a-bad-5-65-1
    :parameters ()
    :precondition (and (at bad-4-21-2))
    :effect (and (not (at bad-4-21-2)) (at bad-5-65-1) (increase (total-cost) 1)))

  (:action a-bad-5-65-2
    :parameters ()
    :precondition (and (at bad-4-21-2))
    :effect (and (not (at bad-4-21-2)) (at bad-5-65-2) (increase (total-cost) 1)))

  (:action a-bad-5-66-0
    :parameters ()
    :precondition (and (at bad-4-22-0))
    :effect (and (not (at bad-4-22-0)) (at bad-5-66-0) (increase (total-cost) 1)))

  (:action a-bad-5-66-1
    :parameters ()
    :precondition (and (at bad-4-22-0))
    :effect (and (not (at bad-4-22-0)) (at bad-5-66-1) (increase (total-cost) 1)))

  (:action a-bad-5-66-2
    :parameters ()
    :precondition (and (at bad-4-22-0))
    :effect (and (not (at bad-4-22-0)) (at bad-5-66-2) (increase (total-cost) 1)))

  (:action a-bad-5-67-0
    :parameters ()
    :precondition (and (at bad-4-22-1))
    :effect (and (not (at bad-4-22-1)) (at bad-5-67-0) (increase (total-cost) 1)))

  (:action a-bad-5-67-1
    :parameters ()
    :precondition (and (at bad-4-22-1))
    :effect (and (not (at bad-4-22-1)) (at bad-5-67-1) (increase (total-cost) 1)))

  (:action a-bad-5-67-2
    :parameters ()
    :precondition (and (at bad-4-22-1))
    :effect (and (not (at bad-4-22-1)) (at bad-5-67-2) (increase (total-cost) 1)))

  (:action a-bad-5-68-0
    :parameters ()
    :precondition (and (at bad-4-22-2))
    :effect (and (not (at bad-4-22-2)) (at bad-5-68-0) (increase (total-cost) 1)))

  (:action a-bad-5-68-1
    :parameters ()
    :precondition (and (at bad-4-22-2))
    :effect (and (not (at bad-4-22-2)) (at bad-5-68-1) (increase (total-cost) 1)))

  (:action a-bad-5-68-2
    :parameters ()
    :precondition (and (at bad-4-22-2))
    :effect (and (not (at bad-4-22-2)) (at bad-5-68-2) (increase (total-cost) 1)))

  (:action a-bad-5-69-0
    :parameters ()
    :precondition (and (at bad-4-23-0))
    :effect (and (not (at bad-4-23-0)) (at bad-5-69-0) (increase (total-cost) 1)))

  (:action a-bad-5-69-1
    :parameters ()
    :precondition (and (at bad-4-23-0))
    :effect (and (not (at bad-4-23-0)) (at bad-5-69-1) (increase (total-cost) 1)))

  (:action a-bad-5-69-2
    :parameters ()
    :precondition (and (at bad-4-23-0))
    :effect (and (not (at bad-4-23-0)) (at bad-5-69-2) (increase (total-cost) 1)))

  (:action a-bad-5-70-0
    :parameters ()
    :precondition (and (at bad-4-23-1))
    :effect (and (not (at bad-4-23-1)) (at bad-5-70-0) (increase (total-cost) 1)))

  (:action a-bad-5-70-1
    :parameters ()
    :precondition (and (at bad-4-23-1))
    :effect (and (not (at bad-4-23-1)) (at bad-5-70-1) (increase (total-cost) 1)))

  (:action a-bad-5-70-2
    :parameters ()
    :precondition (and (at bad-4-23-1))
    :effect (and (not (at bad-4-23-1)) (at bad-5-70-2) (increase (total-cost) 1)))

  (:action a-bad-5-71-0
    :parameters ()
    :precondition (and (at bad-4-23-2))
    :effect (and (not (at bad-4-23-2)) (at bad-5-71-0) (increase (total-cost) 1)))

  (:action a-bad-5-71-1
    :parameters ()
    :precondition (and (at bad-4-23-2))
    :effect (and (not (at bad-4-23-2)) (at bad-5-71-1) (increase (total-cost) 1)))

  (:action a-bad-5-71-2
    :parameters ()
    :precondition (and (at bad-4-23-2))
    :effect (and (not (at bad-4-23-2)) (at bad-5-71-2) (increase (total-cost) 1)))

  (:action a-bad-5-72-0
    :parameters ()
    :precondition (and (at bad-4-24-0))
    :effect (and (not (at bad-4-24-0)) (at bad-5-72-0) (increase (total-cost) 1)))

  (:action a-bad-5-72-1
    :parameters ()
    :precondition (and (at bad-4-24-0))
    :effect (and (not (at bad-4-24-0)) (at bad-5-72-1) (increase (total-cost) 1)))

  (:action a-bad-5-72-2
    :parameters ()
    :precondition (and (at bad-4-24-0))
    :effect (and (not (at bad-4-24-0)) (at bad-5-72-2) (increase (total-cost) 1)))

  (:action a-bad-5-73-0
    :parameters ()
    :precondition (and (at bad-4-24-1))
    :effect (and (not (at bad-4-24-1)) (at bad-5-73-0) (increase (total-cost) 1)))

  (:action a-bad-5-73-1
    :parameters ()
    :precondition (and (at bad-4-24-1))
    :effect (and (not (at bad-4-24-1)) (at bad-5-73-1) (increase (total-cost) 1)))

  (:action a-bad-5-73-2
    :parameters ()
    :precondition (and (at bad-4-24-1))
    :effect (and (not (at bad-4-24-1)) (at bad-5-73-2) (increase (total-cost) 1)))

  (:action a-bad-5-74-0
    :parameters ()
    :precondition (and (at bad-4-24-2))
    :effect (and (not (at bad-4-24-2)) (at bad-5-74-0) (increase (total-cost) 1)))

  (:action a-bad-5-74-1
    :parameters ()
    :precondition (and (at bad-4-24-2))
    :effect (and (not (at bad-4-24-2)) (at bad-5-74-1) (increase (total-cost) 1)))

  (:action a-bad-5-74-2
    :parameters ()
    :precondition (and (at bad-4-24-2))
    :effect (and (not (at bad-4-24-2)) (at bad-5-74-2) (increase (total-cost) 1)))

  (:action a-bad-5-75-0
    :parameters ()
    :precondition (and (at bad-4-25-0))
    :effect (and (not (at bad-4-25-0)) (at bad-5-75-0) (increase (total-cost) 1)))

  (:action a-bad-5-75-1
    :parameters ()
    :precondition (and (at bad-4-25-0))
    :effect (and (not (at bad-4-25-0)) (at bad-5-75-1) (increase (total-cost) 1)))

  (:action a-bad-5-75-2
    :parameters ()
    :precondition (and (at bad-4-25-0))
    :effect (and (not (at bad-4-25-0)) (at bad-5-75-2) (increase (total-cost) 1)))

  (:action a-bad-5-76-0
    :parameters ()
    :precondition (and (at bad-4-25-1))
    :effect (and (not (at bad-4-25-1)) (at bad-5-76-0) (increase (total-cost) 1)))

  (:action a-bad-5-76-1
    :parameters ()
    :precondition (and (at bad-4-25-1))
    :effect (and (not (at bad-4-25-1)) (at bad-5-76-1) (increase (total-cost) 1)))

  (:action a-bad-5-76-2
    :parameters ()
    :precondition (and (at bad-4-25-1))
    :effect (and (not (at bad-4-25-1)) (at bad-5-76-2) (increase (total-cost) 1)))

  (:action a-bad-5-77-0
    :parameters ()
    :precondition (and (at bad-4-25-2))
    :effect (and (not (at bad-4-25-2)) (at bad-5-77-0) (increase (total-cost) 1)))

  (:action a-bad-5-77-1
    :parameters ()
    :precondition (and (at bad-4-25-2))
    :effect (and (not (at bad-4-25-2)) (at bad-5-77-1) (increase (total-cost) 1)))

  (:action a-bad-5-77-2
    :parameters ()
    :precondition (and (at bad-4-25-2))
    :effect (and (not (at bad-4-25-2)) (at bad-5-77-2) (increase (total-cost) 1)))

  (:action a-bad-5-78-0
    :parameters ()
    :precondition (and (at bad-4-26-0))
    :effect (and (not (at bad-4-26-0)) (at bad-5-78-0) (increase (total-cost) 1)))

  (:action a-bad-5-78-1
    :parameters ()
    :precondition (and (at bad-4-26-0))
    :effect (and (not (at bad-4-26-0)) (at bad-5-78-1) (increase (total-cost) 1)))

  (:action a-bad-5-78-2
    :parameters ()
    :precondition (and (at bad-4-26-0))
    :effect (and (not (at bad-4-26-0)) (at bad-5-78-2) (increase (total-cost) 1)))

  (:action a-bad-5-79-0
    :parameters ()
    :precondition (and (at bad-4-26-1))
    :effect (and (not (at bad-4-26-1)) (at bad-5-79-0) (increase (total-cost) 1)))

  (:action a-bad-5-79-1
    :parameters ()
    :precondition (and (at bad-4-26-1))
    :effect (and (not (at bad-4-26-1)) (at bad-5-79-1) (increase (total-cost) 1)))

  (:action a-bad-5-79-2
    :parameters ()
    :precondition (and (at bad-4-26-1))
    :effect (and (not (at bad-4-26-1)) (at bad-5-79-2) (increase (total-cost) 1)))

  (:action a-bad-5-80-0
    :parameters ()
    :precondition (and (at bad-4-26-2))
    :effect (and (not (at bad-4-26-2)) (at bad-5-80-0) (increase (total-cost) 1)))

  (:action a-bad-5-80-1
    :parameters ()
    :precondition (and (at bad-4-26-2))
    :effect (and (not (at bad-4-26-2)) (at bad-5-80-1) (increase (total-cost) 1)))

  (:action a-bad-5-80-2
    :parameters ()
    :precondition (and (at bad-4-26-2))
    :effect (and (not (at bad-4-26-2)) (at bad-5-80-2) (increase (total-cost) 1)))

  (:action a-bad-6-0-0
    :parameters ()
    :precondition (and (at bad-5-0-0))
    :effect (and (not (at bad-5-0-0)) (at bad-6-0-0) (increase (total-cost) 1)))

  (:action a-bad-6-0-1
    :parameters ()
    :precondition (and (at bad-5-0-0))
    :effect (and (not (at bad-5-0-0)) (at bad-6-0-1) (increase (total-cost) 1)))

  (:action a-bad-6-0-2
    :parameters ()
    :precondition (and (at bad-5-0-0))
    :effect (and (not (at bad-5-0-0)) (at bad-6-0-2) (increase (total-cost) 1)))

  (:action a-bad-6-1-0
    :parameters ()
    :precondition (and (at bad-5-0-1))
    :effect (and (not (at bad-5-0-1)) (at bad-6-1-0) (increase (total-cost) 1)))

  (:action a-bad-6-1-1
    :parameters ()
    :precondition (and (at bad-5-0-1))
    :effect (and (not (at bad-5-0-1)) (at bad-6-1-1) (increase (total-cost) 1)))

  (:action a-bad-6-1-2
    :parameters ()
    :precondition (and (at bad-5-0-1))
    :effect (and (not (at bad-5-0-1)) (at bad-6-1-2) (increase (total-cost) 1)))

  (:action a-bad-6-2-0
    :parameters ()
    :precondition (and (at bad-5-0-2))
    :effect (and (not (at bad-5-0-2)) (at bad-6-2-0) (increase (total-cost) 1)))

  (:action a-bad-6-2-1
    :parameters ()
    :precondition (and (at bad-5-0-2))
    :effect (and (not (at bad-5-0-2)) (at bad-6-2-1) (increase (total-cost) 1)))

  (:action a-bad-6-2-2
    :parameters ()
    :precondition (and (at bad-5-0-2))
    :effect (and (not (at bad-5-0-2)) (at bad-6-2-2) (increase (total-cost) 1)))

  (:action a-bad-6-3-0
    :parameters ()
    :precondition (and (at bad-5-1-0))
    :effect (and (not (at bad-5-1-0)) (at bad-6-3-0) (increase (total-cost) 1)))

  (:action a-bad-6-3-1
    :parameters ()
    :precondition (and (at bad-5-1-0))
    :effect (and (not (at bad-5-1-0)) (at bad-6-3-1) (increase (total-cost) 1)))

  (:action a-bad-6-3-2
    :parameters ()
    :precondition (and (at bad-5-1-0))
    :effect (and (not (at bad-5-1-0)) (at bad-6-3-2) (increase (total-cost) 1)))

  (:action a-bad-6-4-0
    :parameters ()
    :precondition (and (at bad-5-1-1))
    :effect (and (not (at bad-5-1-1)) (at bad-6-4-0) (increase (total-cost) 1)))

  (:action a-bad-6-4-1
    :parameters ()
    :precondition (and (at bad-5-1-1))
    :effect (and (not (at bad-5-1-1)) (at bad-6-4-1) (increase (total-cost) 1)))

  (:action a-bad-6-4-2
    :parameters ()
    :precondition (and (at bad-5-1-1))
    :effect (and (not (at bad-5-1-1)) (at bad-6-4-2) (increase (total-cost) 1)))

  (:action a-bad-6-5-0
    :parameters ()
    :precondition (and (at bad-5-1-2))
    :effect (and (not (at bad-5-1-2)) (at bad-6-5-0) (increase (total-cost) 1)))

  (:action a-bad-6-5-1
    :parameters ()
    :precondition (and (at bad-5-1-2))
    :effect (and (not (at bad-5-1-2)) (at bad-6-5-1) (increase (total-cost) 1)))

  (:action a-bad-6-5-2
    :parameters ()
    :precondition (and (at bad-5-1-2))
    :effect (and (not (at bad-5-1-2)) (at bad-6-5-2) (increase (total-cost) 1)))

  (:action a-bad-6-6-0
    :parameters ()
    :precondition (and (at bad-5-2-0))
    :effect (and (not (at bad-5-2-0)) (at bad-6-6-0) (increase (total-cost) 1)))

  (:action a-bad-6-6-1
    :parameters ()
    :precondition (and (at bad-5-2-0))
    :effect (and (not (at bad-5-2-0)) (at bad-6-6-1) (increase (total-cost) 1)))

  (:action a-bad-6-6-2
    :parameters ()
    :precondition (and (at bad-5-2-0))
    :effect (and (not (at bad-5-2-0)) (at bad-6-6-2) (increase (total-cost) 1)))

  (:action a-bad-6-7-0
    :parameters ()
    :precondition (and (at bad-5-2-1))
    :effect (and (not (at bad-5-2-1)) (at bad-6-7-0) (increase (total-cost) 1)))

  (:action a-bad-6-7-1
    :parameters ()
    :precondition (and (at bad-5-2-1))
    :effect (and (not (at bad-5-2-1)) (at bad-6-7-1) (increase (total-cost) 1)))

  (:action a-bad-6-7-2
    :parameters ()
    :precondition (and (at bad-5-2-1))
    :effect (and (not (at bad-5-2-1)) (at bad-6-7-2) (increase (total-cost) 1)))

  (:action a-bad-6-8-0
    :parameters ()
    :precondition (and (at bad-5-2-2))
    :effect (and (not (at bad-5-2-2)) (at bad-6-8-0) (increase (total-cost) 1)))

  (:action a-bad-6-8-1
    :parameters ()
    :precondition (and (at bad-5-2-2))
    :effect (and (not (at bad-5-2-2)) (at bad-6-8-1) (increase (total-cost) 1)))

  (:action a-bad-6-8-2
    :parameters ()
    :precondition (and (at bad-5-2-2))
    :effect (and (not (at bad-5-2-2)) (at bad-6-8-2) (increase (total-cost) 1)))

  (:action a-bad-6-9-0
    :parameters ()
    :precondition (and (at bad-5-3-0))
    :effect (and (not (at bad-5-3-0)) (at bad-6-9-0) (increase (total-cost) 1)))

  (:action a-bad-6-9-1
    :parameters ()
    :precondition (and (at bad-5-3-0))
    :effect (and (not (at bad-5-3-0)) (at bad-6-9-1) (increase (total-cost) 1)))

  (:action a-bad-6-9-2
    :parameters ()
    :precondition (and (at bad-5-3-0))
    :effect (and (not (at bad-5-3-0)) (at bad-6-9-2) (increase (total-cost) 1)))

  (:action a-bad-6-10-0
    :parameters ()
    :precondition (and (at bad-5-3-1))
    :effect (and (not (at bad-5-3-1)) (at bad-6-10-0) (increase (total-cost) 1)))

  (:action a-bad-6-10-1
    :parameters ()
    :precondition (and (at bad-5-3-1))
    :effect (and (not (at bad-5-3-1)) (at bad-6-10-1) (increase (total-cost) 1)))

  (:action a-bad-6-10-2
    :parameters ()
    :precondition (and (at bad-5-3-1))
    :effect (and (not (at bad-5-3-1)) (at bad-6-10-2) (increase (total-cost) 1)))

  (:action a-bad-6-11-0
    :parameters ()
    :precondition (and (at bad-5-3-2))
    :effect (and (not (at bad-5-3-2)) (at bad-6-11-0) (increase (total-cost) 1)))

  (:action a-bad-6-11-1
    :parameters ()
    :precondition (and (at bad-5-3-2))
    :effect (and (not (at bad-5-3-2)) (at bad-6-11-1) (increase (total-cost) 1)))

  (:action a-bad-6-11-2
    :parameters ()
    :precondition (and (at bad-5-3-2))
    :effect (and (not (at bad-5-3-2)) (at bad-6-11-2) (increase (total-cost) 1)))

  (:action a-bad-6-12-0
    :parameters ()
    :precondition (and (at bad-5-4-0))
    :effect (and (not (at bad-5-4-0)) (at bad-6-12-0) (increase (total-cost) 1)))

  (:action a-bad-6-12-1
    :parameters ()
    :precondition (and (at bad-5-4-0))
    :effect (and (not (at bad-5-4-0)) (at bad-6-12-1) (increase (total-cost) 1)))

  (:action a-bad-6-12-2
    :parameters ()
    :precondition (and (at bad-5-4-0))
    :effect (and (not (at bad-5-4-0)) (at bad-6-12-2) (increase (total-cost) 1)))

  (:action a-bad-6-13-0
    :parameters ()
    :precondition (and (at bad-5-4-1))
    :effect (and (not (at bad-5-4-1)) (at bad-6-13-0) (increase (total-cost) 1)))

  (:action a-bad-6-13-1
    :parameters ()
    :precondition (and (at bad-5-4-1))
    :effect (and (not (at bad-5-4-1)) (at bad-6-13-1) (increase (total-cost) 1)))

  (:action a-bad-6-13-2
    :parameters ()
    :precondition (and (at bad-5-4-1))
    :effect (and (not (at bad-5-4-1)) (at bad-6-13-2) (increase (total-cost) 1)))

  (:action a-bad-6-14-0
    :parameters ()
    :precondition (and (at bad-5-4-2))
    :effect (and (not (at bad-5-4-2)) (at bad-6-14-0) (increase (total-cost) 1)))

  (:action a-bad-6-14-1
    :parameters ()
    :precondition (and (at bad-5-4-2))
    :effect (and (not (at bad-5-4-2)) (at bad-6-14-1) (increase (total-cost) 1)))

  (:action a-bad-6-14-2
    :parameters ()
    :precondition (and (at bad-5-4-2))
    :effect (and (not (at bad-5-4-2)) (at bad-6-14-2) (increase (total-cost) 1)))

  (:action a-bad-6-15-0
    :parameters ()
    :precondition (and (at bad-5-5-0))
    :effect (and (not (at bad-5-5-0)) (at bad-6-15-0) (increase (total-cost) 1)))

  (:action a-bad-6-15-1
    :parameters ()
    :precondition (and (at bad-5-5-0))
    :effect (and (not (at bad-5-5-0)) (at bad-6-15-1) (increase (total-cost) 1)))

  (:action a-bad-6-15-2
    :parameters ()
    :precondition (and (at bad-5-5-0))
    :effect (and (not (at bad-5-5-0)) (at bad-6-15-2) (increase (total-cost) 1)))

  (:action a-bad-6-16-0
    :parameters ()
    :precondition (and (at bad-5-5-1))
    :effect (and (not (at bad-5-5-1)) (at bad-6-16-0) (increase (total-cost) 1)))

  (:action a-bad-6-16-1
    :parameters ()
    :precondition (and (at bad-5-5-1))
    :effect (and (not (at bad-5-5-1)) (at bad-6-16-1) (increase (total-cost) 1)))

  (:action a-bad-6-16-2
    :parameters ()
    :precondition (and (at bad-5-5-1))
    :effect (and (not (at bad-5-5-1)) (at bad-6-16-2) (increase (total-cost) 1)))

  (:action a-bad-6-17-0
    :parameters ()
    :precondition (and (at bad-5-5-2))
    :effect (and (not (at bad-5-5-2)) (at bad-6-17-0) (increase (total-cost) 1)))

  (:action a-bad-6-17-1
    :parameters ()
    :precondition (and (at bad-5-5-2))
    :effect (and (not (at bad-5-5-2)) (at bad-6-17-1) (increase (total-cost) 1)))

  (:action a-bad-6-17-2
    :parameters ()
    :precondition (and (at bad-5-5-2))
    :effect (and (not (at bad-5-5-2)) (at bad-6-17-2) (increase (total-cost) 1)))

  (:action a-bad-6-18-0
    :parameters ()
    :precondition (and (at bad-5-6-0))
    :effect (and (not (at bad-5-6-0)) (at bad-6-18-0) (increase (total-cost) 1)))

  (:action a-bad-6-18-1
    :parameters ()
    :precondition (and (at bad-5-6-0))
    :effect (and (not (at bad-5-6-0)) (at bad-6-18-1) (increase (total-cost) 1)))

  (:action a-bad-6-18-2
    :parameters ()
    :precondition (and (at bad-5-6-0))
    :effect (and (not (at bad-5-6-0)) (at bad-6-18-2) (increase (total-cost) 1)))

  (:action a-bad-6-19-0
    :parameters ()
    :precondition (and (at bad-5-6-1))
    :effect (and (not (at bad-5-6-1)) (at bad-6-19-0) (increase (total-cost) 1)))

  (:action a-bad-6-19-1
    :parameters ()
    :precondition (and (at bad-5-6-1))
    :effect (and (not (at bad-5-6-1)) (at bad-6-19-1) (increase (total-cost) 1)))

  (:action a-bad-6-19-2
    :parameters ()
    :precondition (and (at bad-5-6-1))
    :effect (and (not (at bad-5-6-1)) (at bad-6-19-2) (increase (total-cost) 1)))

  (:action a-bad-6-20-0
    :parameters ()
    :precondition (and (at bad-5-6-2))
    :effect (and (not (at bad-5-6-2)) (at bad-6-20-0) (increase (total-cost) 1)))

  (:action a-bad-6-20-1
    :parameters ()
    :precondition (and (at bad-5-6-2))
    :effect (and (not (at bad-5-6-2)) (at bad-6-20-1) (increase (total-cost) 1)))

  (:action a-bad-6-20-2
    :parameters ()
    :precondition (and (at bad-5-6-2))
    :effect (and (not (at bad-5-6-2)) (at bad-6-20-2) (increase (total-cost) 1)))

  (:action a-bad-6-21-0
    :parameters ()
    :precondition (and (at bad-5-7-0))
    :effect (and (not (at bad-5-7-0)) (at bad-6-21-0) (increase (total-cost) 1)))

  (:action a-bad-6-21-1
    :parameters ()
    :precondition (and (at bad-5-7-0))
    :effect (and (not (at bad-5-7-0)) (at bad-6-21-1) (increase (total-cost) 1)))

  (:action a-bad-6-21-2
    :parameters ()
    :precondition (and (at bad-5-7-0))
    :effect (and (not (at bad-5-7-0)) (at bad-6-21-2) (increase (total-cost) 1)))

  (:action a-bad-6-22-0
    :parameters ()
    :precondition (and (at bad-5-7-1))
    :effect (and (not (at bad-5-7-1)) (at bad-6-22-0) (increase (total-cost) 1)))

  (:action a-bad-6-22-1
    :parameters ()
    :precondition (and (at bad-5-7-1))
    :effect (and (not (at bad-5-7-1)) (at bad-6-22-1) (increase (total-cost) 1)))

  (:action a-bad-6-22-2
    :parameters ()
    :precondition (and (at bad-5-7-1))
    :effect (and (not (at bad-5-7-1)) (at bad-6-22-2) (increase (total-cost) 1)))

  (:action a-bad-6-23-0
    :parameters ()
    :precondition (and (at bad-5-7-2))
    :effect (and (not (at bad-5-7-2)) (at bad-6-23-0) (increase (total-cost) 1)))

  (:action a-bad-6-23-1
    :parameters ()
    :precondition (and (at bad-5-7-2))
    :effect (and (not (at bad-5-7-2)) (at bad-6-23-1) (increase (total-cost) 1)))

  (:action a-bad-6-23-2
    :parameters ()
    :precondition (and (at bad-5-7-2))
    :effect (and (not (at bad-5-7-2)) (at bad-6-23-2) (increase (total-cost) 1)))

  (:action a-bad-6-24-0
    :parameters ()
    :precondition (and (at bad-5-8-0))
    :effect (and (not (at bad-5-8-0)) (at bad-6-24-0) (increase (total-cost) 1)))

  (:action a-bad-6-24-1
    :parameters ()
    :precondition (and (at bad-5-8-0))
    :effect (and (not (at bad-5-8-0)) (at bad-6-24-1) (increase (total-cost) 1)))

  (:action a-bad-6-24-2
    :parameters ()
    :precondition (and (at bad-5-8-0))
    :effect (and (not (at bad-5-8-0)) (at bad-6-24-2) (increase (total-cost) 1)))

  (:action a-bad-6-25-0
    :parameters ()
    :precondition (and (at bad-5-8-1))
    :effect (and (not (at bad-5-8-1)) (at bad-6-25-0) (increase (total-cost) 1)))

  (:action a-bad-6-25-1
    :parameters ()
    :precondition (and (at bad-5-8-1))
    :effect (and (not (at bad-5-8-1)) (at bad-6-25-1) (increase (total-cost) 1)))

  (:action a-bad-6-25-2
    :parameters ()
    :precondition (and (at bad-5-8-1))
    :effect (and (not (at bad-5-8-1)) (at bad-6-25-2) (increase (total-cost) 1)))

  (:action a-bad-6-26-0
    :parameters ()
    :precondition (and (at bad-5-8-2))
    :effect (and (not (at bad-5-8-2)) (at bad-6-26-0) (increase (total-cost) 1)))

  (:action a-bad-6-26-1
    :parameters ()
    :precondition (and (at bad-5-8-2))
    :effect (and (not (at bad-5-8-2)) (at bad-6-26-1) (increase (total-cost) 1)))

  (:action a-bad-6-26-2
    :parameters ()
    :precondition (and (at bad-5-8-2))
    :effect (and (not (at bad-5-8-2)) (at bad-6-26-2) (increase (total-cost) 1)))

  (:action a-bad-6-27-0
    :parameters ()
    :precondition (and (at bad-5-9-0))
    :effect (and (not (at bad-5-9-0)) (at bad-6-27-0) (increase (total-cost) 1)))

  (:action a-bad-6-27-1
    :parameters ()
    :precondition (and (at bad-5-9-0))
    :effect (and (not (at bad-5-9-0)) (at bad-6-27-1) (increase (total-cost) 1)))

  (:action a-bad-6-27-2
    :parameters ()
    :precondition (and (at bad-5-9-0))
    :effect (and (not (at bad-5-9-0)) (at bad-6-27-2) (increase (total-cost) 1)))

  (:action a-bad-6-28-0
    :parameters ()
    :precondition (and (at bad-5-9-1))
    :effect (and (not (at bad-5-9-1)) (at bad-6-28-0) (increase (total-cost) 1)))

  (:action a-bad-6-28-1
    :parameters ()
    :precondition (and (at bad-5-9-1))
    :effect (and (not (at bad-5-9-1)) (at bad-6-28-1) (increase (total-cost) 1)))

  (:action a-bad-6-28-2
    :parameters ()
    :precondition (and (at bad-5-9-1))
    :effect (and (not (at bad-5-9-1)) (at bad-6-28-2) (increase (total-cost) 1)))

  (:action a-bad-6-29-0
    :parameters ()
    :precondition (and (at bad-5-9-2))
    :effect (and (not (at bad-5-9-2)) (at bad-6-29-0) (increase (total-cost) 1)))

  (:action a-bad-6-29-1
    :parameters ()
    :precondition (and (at bad-5-9-2))
    :effect (and (not (at bad-5-9-2)) (at bad-6-29-1) (increase (total-cost) 1)))

  (:action a-bad-6-29-2
    :parameters ()
    :precondition (and (at bad-5-9-2))
    :effect (and (not (at bad-5-9-2)) (at bad-6-29-2) (increase (total-cost) 1)))

  (:action a-bad-6-30-0
    :parameters ()
    :precondition (and (at bad-5-10-0))
    :effect (and (not (at bad-5-10-0)) (at bad-6-30-0) (increase (total-cost) 1)))

  (:action a-bad-6-30-1
    :parameters ()
    :precondition (and (at bad-5-10-0))
    :effect (and (not (at bad-5-10-0)) (at bad-6-30-1) (increase (total-cost) 1)))

  (:action a-bad-6-30-2
    :parameters ()
    :precondition (and (at bad-5-10-0))
    :effect (and (not (at bad-5-10-0)) (at bad-6-30-2) (increase (total-cost) 1)))

  (:action a-bad-6-31-0
    :parameters ()
    :precondition (and (at bad-5-10-1))
    :effect (and (not (at bad-5-10-1)) (at bad-6-31-0) (increase (total-cost) 1)))

  (:action a-bad-6-31-1
    :parameters ()
    :precondition (and (at bad-5-10-1))
    :effect (and (not (at bad-5-10-1)) (at bad-6-31-1) (increase (total-cost) 1)))

  (:action a-bad-6-31-2
    :parameters ()
    :precondition (and (at bad-5-10-1))
    :effect (and (not (at bad-5-10-1)) (at bad-6-31-2) (increase (total-cost) 1)))

  (:action a-bad-6-32-0
    :parameters ()
    :precondition (and (at bad-5-10-2))
    :effect (and (not (at bad-5-10-2)) (at bad-6-32-0) (increase (total-cost) 1)))

  (:action a-bad-6-32-1
    :parameters ()
    :precondition (and (at bad-5-10-2))
    :effect (and (not (at bad-5-10-2)) (at bad-6-32-1) (increase (total-cost) 1)))

  (:action a-bad-6-32-2
    :parameters ()
    :precondition (and (at bad-5-10-2))
    :effect (and (not (at bad-5-10-2)) (at bad-6-32-2) (increase (total-cost) 1)))

  (:action a-bad-6-33-0
    :parameters ()
    :precondition (and (at bad-5-11-0))
    :effect (and (not (at bad-5-11-0)) (at bad-6-33-0) (increase (total-cost) 1)))

  (:action a-bad-6-33-1
    :parameters ()
    :precondition (and (at bad-5-11-0))
    :effect (and (not (at bad-5-11-0)) (at bad-6-33-1) (increase (total-cost) 1)))

  (:action a-bad-6-33-2
    :parameters ()
    :precondition (and (at bad-5-11-0))
    :effect (and (not (at bad-5-11-0)) (at bad-6-33-2) (increase (total-cost) 1)))

  (:action a-bad-6-34-0
    :parameters ()
    :precondition (and (at bad-5-11-1))
    :effect (and (not (at bad-5-11-1)) (at bad-6-34-0) (increase (total-cost) 1)))

  (:action a-bad-6-34-1
    :parameters ()
    :precondition (and (at bad-5-11-1))
    :effect (and (not (at bad-5-11-1)) (at bad-6-34-1) (increase (total-cost) 1)))

  (:action a-bad-6-34-2
    :parameters ()
    :precondition (and (at bad-5-11-1))
    :effect (and (not (at bad-5-11-1)) (at bad-6-34-2) (increase (total-cost) 1)))

  (:action a-bad-6-35-0
    :parameters ()
    :precondition (and (at bad-5-11-2))
    :effect (and (not (at bad-5-11-2)) (at bad-6-35-0) (increase (total-cost) 1)))

  (:action a-bad-6-35-1
    :parameters ()
    :precondition (and (at bad-5-11-2))
    :effect (and (not (at bad-5-11-2)) (at bad-6-35-1) (increase (total-cost) 1)))

  (:action a-bad-6-35-2
    :parameters ()
    :precondition (and (at bad-5-11-2))
    :effect (and (not (at bad-5-11-2)) (at bad-6-35-2) (increase (total-cost) 1)))

  (:action a-bad-6-36-0
    :parameters ()
    :precondition (and (at bad-5-12-0))
    :effect (and (not (at bad-5-12-0)) (at bad-6-36-0) (increase (total-cost) 1)))

  (:action a-bad-6-36-1
    :parameters ()
    :precondition (and (at bad-5-12-0))
    :effect (and (not (at bad-5-12-0)) (at bad-6-36-1) (increase (total-cost) 1)))

  (:action a-bad-6-36-2
    :parameters ()
    :precondition (and (at bad-5-12-0))
    :effect (and (not (at bad-5-12-0)) (at bad-6-36-2) (increase (total-cost) 1)))

  (:action a-bad-6-37-0
    :parameters ()
    :precondition (and (at bad-5-12-1))
    :effect (and (not (at bad-5-12-1)) (at bad-6-37-0) (increase (total-cost) 1)))

  (:action a-bad-6-37-1
    :parameters ()
    :precondition (and (at bad-5-12-1))
    :effect (and (not (at bad-5-12-1)) (at bad-6-37-1) (increase (total-cost) 1)))

  (:action a-bad-6-37-2
    :parameters ()
    :precondition (and (at bad-5-12-1))
    :effect (and (not (at bad-5-12-1)) (at bad-6-37-2) (increase (total-cost) 1)))

  (:action a-bad-6-38-0
    :parameters ()
    :precondition (and (at bad-5-12-2))
    :effect (and (not (at bad-5-12-2)) (at bad-6-38-0) (increase (total-cost) 1)))

  (:action a-bad-6-38-1
    :parameters ()
    :precondition (and (at bad-5-12-2))
    :effect (and (not (at bad-5-12-2)) (at bad-6-38-1) (increase (total-cost) 1)))

  (:action a-bad-6-38-2
    :parameters ()
    :precondition (and (at bad-5-12-2))
    :effect (and (not (at bad-5-12-2)) (at bad-6-38-2) (increase (total-cost) 1)))

  (:action a-bad-6-39-0
    :parameters ()
    :precondition (and (at bad-5-13-0))
    :effect (and (not (at bad-5-13-0)) (at bad-6-39-0) (increase (total-cost) 1)))

  (:action a-bad-6-39-1
    :parameters ()
    :precondition (and (at bad-5-13-0))
    :effect (and (not (at bad-5-13-0)) (at bad-6-39-1) (increase (total-cost) 1)))

  (:action a-bad-6-39-2
    :parameters ()
    :precondition (and (at bad-5-13-0))
    :effect (and (not (at bad-5-13-0)) (at bad-6-39-2) (increase (total-cost) 1)))

  (:action a-bad-6-40-0
    :parameters ()
    :precondition (and (at bad-5-13-1))
    :effect (and (not (at bad-5-13-1)) (at bad-6-40-0) (increase (total-cost) 1)))

  (:action a-bad-6-40-1
    :parameters ()
    :precondition (and (at bad-5-13-1))
    :effect (and (not (at bad-5-13-1)) (at bad-6-40-1) (increase (total-cost) 1)))

  (:action a-bad-6-40-2
    :parameters ()
    :precondition (and (at bad-5-13-1))
    :effect (and (not (at bad-5-13-1)) (at bad-6-40-2) (increase (total-cost) 1)))

  (:action a-bad-6-41-0
    :parameters ()
    :precondition (and (at bad-5-13-2))
    :effect (and (not (at bad-5-13-2)) (at bad-6-41-0) (increase (total-cost) 1)))

  (:action a-bad-6-41-1
    :parameters ()
    :precondition (and (at bad-5-13-2))
    :effect (and (not (at bad-5-13-2)) (at bad-6-41-1) (increase (total-cost) 1)))

  (:action a-bad-6-41-2
    :parameters ()
    :precondition (and (at bad-5-13-2))
    :effect (and (not (at bad-5-13-2)) (at bad-6-41-2) (increase (total-cost) 1)))

  (:action a-bad-6-42-0
    :parameters ()
    :precondition (and (at bad-5-14-0))
    :effect (and (not (at bad-5-14-0)) (at bad-6-42-0) (increase (total-cost) 1)))

  (:action a-bad-6-42-1
    :parameters ()
    :precondition (and (at bad-5-14-0))
    :effect (and (not (at bad-5-14-0)) (at bad-6-42-1) (increase (total-cost) 1)))

  (:action a-bad-6-42-2
    :parameters ()
    :precondition (and (at bad-5-14-0))
    :effect (and (not (at bad-5-14-0)) (at bad-6-42-2) (increase (total-cost) 1)))

  (:action a-bad-6-43-0
    :parameters ()
    :precondition (and (at bad-5-14-1))
    :effect (and (not (at bad-5-14-1)) (at bad-6-43-0) (increase (total-cost) 1)))

  (:action a-bad-6-43-1
    :parameters ()
    :precondition (and (at bad-5-14-1))
    :effect (and (not (at bad-5-14-1)) (at bad-6-43-1) (increase (total-cost) 1)))

  (:action a-bad-6-43-2
    :parameters ()
    :precondition (and (at bad-5-14-1))
    :effect (and (not (at bad-5-14-1)) (at bad-6-43-2) (increase (total-cost) 1)))

  (:action a-bad-6-44-0
    :parameters ()
    :precondition (and (at bad-5-14-2))
    :effect (and (not (at bad-5-14-2)) (at bad-6-44-0) (increase (total-cost) 1)))

  (:action a-bad-6-44-1
    :parameters ()
    :precondition (and (at bad-5-14-2))
    :effect (and (not (at bad-5-14-2)) (at bad-6-44-1) (increase (total-cost) 1)))

  (:action a-bad-6-44-2
    :parameters ()
    :precondition (and (at bad-5-14-2))
    :effect (and (not (at bad-5-14-2)) (at bad-6-44-2) (increase (total-cost) 1)))

  (:action a-bad-6-45-0
    :parameters ()
    :precondition (and (at bad-5-15-0))
    :effect (and (not (at bad-5-15-0)) (at bad-6-45-0) (increase (total-cost) 1)))

  (:action a-bad-6-45-1
    :parameters ()
    :precondition (and (at bad-5-15-0))
    :effect (and (not (at bad-5-15-0)) (at bad-6-45-1) (increase (total-cost) 1)))

  (:action a-bad-6-45-2
    :parameters ()
    :precondition (and (at bad-5-15-0))
    :effect (and (not (at bad-5-15-0)) (at bad-6-45-2) (increase (total-cost) 1)))

  (:action a-bad-6-46-0
    :parameters ()
    :precondition (and (at bad-5-15-1))
    :effect (and (not (at bad-5-15-1)) (at bad-6-46-0) (increase (total-cost) 1)))

  (:action a-bad-6-46-1
    :parameters ()
    :precondition (and (at bad-5-15-1))
    :effect (and (not (at bad-5-15-1)) (at bad-6-46-1) (increase (total-cost) 1)))

  (:action a-bad-6-46-2
    :parameters ()
    :precondition (and (at bad-5-15-1))
    :effect (and (not (at bad-5-15-1)) (at bad-6-46-2) (increase (total-cost) 1)))

  (:action a-bad-6-47-0
    :parameters ()
    :precondition (and (at bad-5-15-2))
    :effect (and (not (at bad-5-15-2)) (at bad-6-47-0) (increase (total-cost) 1)))

  (:action a-bad-6-47-1
    :parameters ()
    :precondition (and (at bad-5-15-2))
    :effect (and (not (at bad-5-15-2)) (at bad-6-47-1) (increase (total-cost) 1)))

  (:action a-bad-6-47-2
    :parameters ()
    :precondition (and (at bad-5-15-2))
    :effect (and (not (at bad-5-15-2)) (at bad-6-47-2) (increase (total-cost) 1)))

  (:action a-bad-6-48-0
    :parameters ()
    :precondition (and (at bad-5-16-0))
    :effect (and (not (at bad-5-16-0)) (at bad-6-48-0) (increase (total-cost) 1)))

  (:action a-bad-6-48-1
    :parameters ()
    :precondition (and (at bad-5-16-0))
    :effect (and (not (at bad-5-16-0)) (at bad-6-48-1) (increase (total-cost) 1)))

  (:action a-bad-6-48-2
    :parameters ()
    :precondition (and (at bad-5-16-0))
    :effect (and (not (at bad-5-16-0)) (at bad-6-48-2) (increase (total-cost) 1)))

  (:action a-bad-6-49-0
    :parameters ()
    :precondition (and (at bad-5-16-1))
    :effect (and (not (at bad-5-16-1)) (at bad-6-49-0) (increase (total-cost) 1)))

  (:action a-bad-6-49-1
    :parameters ()
    :precondition (and (at bad-5-16-1))
    :effect (and (not (at bad-5-16-1)) (at bad-6-49-1) (increase (total-cost) 1)))

  (:action a-bad-6-49-2
    :parameters ()
    :precondition (and (at bad-5-16-1))
    :effect (and (not (at bad-5-16-1)) (at bad-6-49-2) (increase (total-cost) 1)))

  (:action a-bad-6-50-0
    :parameters ()
    :precondition (and (at bad-5-16-2))
    :effect (and (not (at bad-5-16-2)) (at bad-6-50-0) (increase (total-cost) 1)))

  (:action a-bad-6-50-1
    :parameters ()
    :precondition (and (at bad-5-16-2))
    :effect (and (not (at bad-5-16-2)) (at bad-6-50-1) (increase (total-cost) 1)))

  (:action a-bad-6-50-2
    :parameters ()
    :precondition (and (at bad-5-16-2))
    :effect (and (not (at bad-5-16-2)) (at bad-6-50-2) (increase (total-cost) 1)))

  (:action a-bad-6-51-0
    :parameters ()
    :precondition (and (at bad-5-17-0))
    :effect (and (not (at bad-5-17-0)) (at bad-6-51-0) (increase (total-cost) 1)))

  (:action a-bad-6-51-1
    :parameters ()
    :precondition (and (at bad-5-17-0))
    :effect (and (not (at bad-5-17-0)) (at bad-6-51-1) (increase (total-cost) 1)))

  (:action a-bad-6-51-2
    :parameters ()
    :precondition (and (at bad-5-17-0))
    :effect (and (not (at bad-5-17-0)) (at bad-6-51-2) (increase (total-cost) 1)))

  (:action a-bad-6-52-0
    :parameters ()
    :precondition (and (at bad-5-17-1))
    :effect (and (not (at bad-5-17-1)) (at bad-6-52-0) (increase (total-cost) 1)))

  (:action a-bad-6-52-1
    :parameters ()
    :precondition (and (at bad-5-17-1))
    :effect (and (not (at bad-5-17-1)) (at bad-6-52-1) (increase (total-cost) 1)))

  (:action a-bad-6-52-2
    :parameters ()
    :precondition (and (at bad-5-17-1))
    :effect (and (not (at bad-5-17-1)) (at bad-6-52-2) (increase (total-cost) 1)))

  (:action a-bad-6-53-0
    :parameters ()
    :precondition (and (at bad-5-17-2))
    :effect (and (not (at bad-5-17-2)) (at bad-6-53-0) (increase (total-cost) 1)))

  (:action a-bad-6-53-1
    :parameters ()
    :precondition (and (at bad-5-17-2))
    :effect (and (not (at bad-5-17-2)) (at bad-6-53-1) (increase (total-cost) 1)))

  (:action a-bad-6-53-2
    :parameters ()
    :precondition (and (at bad-5-17-2))
    :effect (and (not (at bad-5-17-2)) (at bad-6-53-2) (increase (total-cost) 1)))

  (:action a-bad-6-54-0
    :parameters ()
    :precondition (and (at bad-5-18-0))
    :effect (and (not (at bad-5-18-0)) (at bad-6-54-0) (increase (total-cost) 1)))

  (:action a-bad-6-54-1
    :parameters ()
    :precondition (and (at bad-5-18-0))
    :effect (and (not (at bad-5-18-0)) (at bad-6-54-1) (increase (total-cost) 1)))

  (:action a-bad-6-54-2
    :parameters ()
    :precondition (and (at bad-5-18-0))
    :effect (and (not (at bad-5-18-0)) (at bad-6-54-2) (increase (total-cost) 1)))

  (:action a-bad-6-55-0
    :parameters ()
    :precondition (and (at bad-5-18-1))
    :effect (and (not (at bad-5-18-1)) (at bad-6-55-0) (increase (total-cost) 1)))

  (:action a-bad-6-55-1
    :parameters ()
    :precondition (and (at bad-5-18-1))
    :effect (and (not (at bad-5-18-1)) (at bad-6-55-1) (increase (total-cost) 1)))

  (:action a-bad-6-55-2
    :parameters ()
    :precondition (and (at bad-5-18-1))
    :effect (and (not (at bad-5-18-1)) (at bad-6-55-2) (increase (total-cost) 1)))

  (:action a-bad-6-56-0
    :parameters ()
    :precondition (and (at bad-5-18-2))
    :effect (and (not (at bad-5-18-2)) (at bad-6-56-0) (increase (total-cost) 1)))

  (:action a-bad-6-56-1
    :parameters ()
    :precondition (and (at bad-5-18-2))
    :effect (and (not (at bad-5-18-2)) (at bad-6-56-1) (increase (total-cost) 1)))

  (:action a-bad-6-56-2
    :parameters ()
    :precondition (and (at bad-5-18-2))
    :effect (and (not (at bad-5-18-2)) (at bad-6-56-2) (increase (total-cost) 1)))

  (:action a-bad-6-57-0
    :parameters ()
    :precondition (and (at bad-5-19-0))
    :effect (and (not (at bad-5-19-0)) (at bad-6-57-0) (increase (total-cost) 1)))

  (:action a-bad-6-57-1
    :parameters ()
    :precondition (and (at bad-5-19-0))
    :effect (and (not (at bad-5-19-0)) (at bad-6-57-1) (increase (total-cost) 1)))

  (:action a-bad-6-57-2
    :parameters ()
    :precondition (and (at bad-5-19-0))
    :effect (and (not (at bad-5-19-0)) (at bad-6-57-2) (increase (total-cost) 1)))

  (:action a-bad-6-58-0
    :parameters ()
    :precondition (and (at bad-5-19-1))
    :effect (and (not (at bad-5-19-1)) (at bad-6-58-0) (increase (total-cost) 1)))

  (:action a-bad-6-58-1
    :parameters ()
    :precondition (and (at bad-5-19-1))
    :effect (and (not (at bad-5-19-1)) (at bad-6-58-1) (increase (total-cost) 1)))

  (:action a-bad-6-58-2
    :parameters ()
    :precondition (and (at bad-5-19-1))
    :effect (and (not (at bad-5-19-1)) (at bad-6-58-2) (increase (total-cost) 1)))

  (:action a-bad-6-59-0
    :parameters ()
    :precondition (and (at bad-5-19-2))
    :effect (and (not (at bad-5-19-2)) (at bad-6-59-0) (increase (total-cost) 1)))

  (:action a-bad-6-59-1
    :parameters ()
    :precondition (and (at bad-5-19-2))
    :effect (and (not (at bad-5-19-2)) (at bad-6-59-1) (increase (total-cost) 1)))

  (:action a-bad-6-59-2
    :parameters ()
    :precondition (and (at bad-5-19-2))
    :effect (and (not (at bad-5-19-2)) (at bad-6-59-2) (increase (total-cost) 1)))

  (:action a-bad-6-60-0
    :parameters ()
    :precondition (and (at bad-5-20-0))
    :effect (and (not (at bad-5-20-0)) (at bad-6-60-0) (increase (total-cost) 1)))

  (:action a-bad-6-60-1
    :parameters ()
    :precondition (and (at bad-5-20-0))
    :effect (and (not (at bad-5-20-0)) (at bad-6-60-1) (increase (total-cost) 1)))

  (:action a-bad-6-60-2
    :parameters ()
    :precondition (and (at bad-5-20-0))
    :effect (and (not (at bad-5-20-0)) (at bad-6-60-2) (increase (total-cost) 1)))

  (:action a-bad-6-61-0
    :parameters ()
    :precondition (and (at bad-5-20-1))
    :effect (and (not (at bad-5-20-1)) (at bad-6-61-0) (increase (total-cost) 1)))

  (:action a-bad-6-61-1
    :parameters ()
    :precondition (and (at bad-5-20-1))
    :effect (and (not (at bad-5-20-1)) (at bad-6-61-1) (increase (total-cost) 1)))

  (:action a-bad-6-61-2
    :parameters ()
    :precondition (and (at bad-5-20-1))
    :effect (and (not (at bad-5-20-1)) (at bad-6-61-2) (increase (total-cost) 1)))

  (:action a-bad-6-62-0
    :parameters ()
    :precondition (and (at bad-5-20-2))
    :effect (and (not (at bad-5-20-2)) (at bad-6-62-0) (increase (total-cost) 1)))

  (:action a-bad-6-62-1
    :parameters ()
    :precondition (and (at bad-5-20-2))
    :effect (and (not (at bad-5-20-2)) (at bad-6-62-1) (increase (total-cost) 1)))

  (:action a-bad-6-62-2
    :parameters ()
    :precondition (and (at bad-5-20-2))
    :effect (and (not (at bad-5-20-2)) (at bad-6-62-2) (increase (total-cost) 1)))

  (:action a-bad-6-63-0
    :parameters ()
    :precondition (and (at bad-5-21-0))
    :effect (and (not (at bad-5-21-0)) (at bad-6-63-0) (increase (total-cost) 1)))

  (:action a-bad-6-63-1
    :parameters ()
    :precondition (and (at bad-5-21-0))
    :effect (and (not (at bad-5-21-0)) (at bad-6-63-1) (increase (total-cost) 1)))

  (:action a-bad-6-63-2
    :parameters ()
    :precondition (and (at bad-5-21-0))
    :effect (and (not (at bad-5-21-0)) (at bad-6-63-2) (increase (total-cost) 1)))

  (:action a-bad-6-64-0
    :parameters ()
    :precondition (and (at bad-5-21-1))
    :effect (and (not (at bad-5-21-1)) (at bad-6-64-0) (increase (total-cost) 1)))

  (:action a-bad-6-64-1
    :parameters ()
    :precondition (and (at bad-5-21-1))
    :effect (and (not (at bad-5-21-1)) (at bad-6-64-1) (increase (total-cost) 1)))

  (:action a-bad-6-64-2
    :parameters ()
    :precondition (and (at bad-5-21-1))
    :effect (and (not (at bad-5-21-1)) (at bad-6-64-2) (increase (total-cost) 1)))

  (:action a-bad-6-65-0
    :parameters ()
    :precondition (and (at bad-5-21-2))
    :effect (and (not (at bad-5-21-2)) (at bad-6-65-0) (increase (total-cost) 1)))

  (:action a-bad-6-65-1
    :parameters ()
    :precondition (and (at bad-5-21-2))
    :effect (and (not (at bad-5-21-2)) (at bad-6-65-1) (increase (total-cost) 1)))

  (:action a-bad-6-65-2
    :parameters ()
    :precondition (and (at bad-5-21-2))
    :effect (and (not (at bad-5-21-2)) (at bad-6-65-2) (increase (total-cost) 1)))

  (:action a-bad-6-66-0
    :parameters ()
    :precondition (and (at bad-5-22-0))
    :effect (and (not (at bad-5-22-0)) (at bad-6-66-0) (increase (total-cost) 1)))

  (:action a-bad-6-66-1
    :parameters ()
    :precondition (and (at bad-5-22-0))
    :effect (and (not (at bad-5-22-0)) (at bad-6-66-1) (increase (total-cost) 1)))

  (:action a-bad-6-66-2
    :parameters ()
    :precondition (and (at bad-5-22-0))
    :effect (and (not (at bad-5-22-0)) (at bad-6-66-2) (increase (total-cost) 1)))

  (:action a-bad-6-67-0
    :parameters ()
    :precondition (and (at bad-5-22-1))
    :effect (and (not (at bad-5-22-1)) (at bad-6-67-0) (increase (total-cost) 1)))

  (:action a-bad-6-67-1
    :parameters ()
    :precondition (and (at bad-5-22-1))
    :effect (and (not (at bad-5-22-1)) (at bad-6-67-1) (increase (total-cost) 1)))

  (:action a-bad-6-67-2
    :parameters ()
    :precondition (and (at bad-5-22-1))
    :effect (and (not (at bad-5-22-1)) (at bad-6-67-2) (increase (total-cost) 1)))

  (:action a-bad-6-68-0
    :parameters ()
    :precondition (and (at bad-5-22-2))
    :effect (and (not (at bad-5-22-2)) (at bad-6-68-0) (increase (total-cost) 1)))

  (:action a-bad-6-68-1
    :parameters ()
    :precondition (and (at bad-5-22-2))
    :effect (and (not (at bad-5-22-2)) (at bad-6-68-1) (increase (total-cost) 1)))

  (:action a-bad-6-68-2
    :parameters ()
    :precondition (and (at bad-5-22-2))
    :effect (and (not (at bad-5-22-2)) (at bad-6-68-2) (increase (total-cost) 1)))

  (:action a-bad-6-69-0
    :parameters ()
    :precondition (and (at bad-5-23-0))
    :effect (and (not (at bad-5-23-0)) (at bad-6-69-0) (increase (total-cost) 1)))

  (:action a-bad-6-69-1
    :parameters ()
    :precondition (and (at bad-5-23-0))
    :effect (and (not (at bad-5-23-0)) (at bad-6-69-1) (increase (total-cost) 1)))

  (:action a-bad-6-69-2
    :parameters ()
    :precondition (and (at bad-5-23-0))
    :effect (and (not (at bad-5-23-0)) (at bad-6-69-2) (increase (total-cost) 1)))

  (:action a-bad-6-70-0
    :parameters ()
    :precondition (and (at bad-5-23-1))
    :effect (and (not (at bad-5-23-1)) (at bad-6-70-0) (increase (total-cost) 1)))

  (:action a-bad-6-70-1
    :parameters ()
    :precondition (and (at bad-5-23-1))
    :effect (and (not (at bad-5-23-1)) (at bad-6-70-1) (increase (total-cost) 1)))

  (:action a-bad-6-70-2
    :parameters ()
    :precondition (and (at bad-5-23-1))
    :effect (and (not (at bad-5-23-1)) (at bad-6-70-2) (increase (total-cost) 1)))

  (:action a-bad-6-71-0
    :parameters ()
    :precondition (and (at bad-5-23-2))
    :effect (and (not (at bad-5-23-2)) (at bad-6-71-0) (increase (total-cost) 1)))

  (:action a-bad-6-71-1
    :parameters ()
    :precondition (and (at bad-5-23-2))
    :effect (and (not (at bad-5-23-2)) (at bad-6-71-1) (increase (total-cost) 1)))

  (:action a-bad-6-71-2
    :parameters ()
    :precondition (and (at bad-5-23-2))
    :effect (and (not (at bad-5-23-2)) (at bad-6-71-2) (increase (total-cost) 1)))

  (:action a-bad-6-72-0
    :parameters ()
    :precondition (and (at bad-5-24-0))
    :effect (and (not (at bad-5-24-0)) (at bad-6-72-0) (increase (total-cost) 1)))

  (:action a-bad-6-72-1
    :parameters ()
    :precondition (and (at bad-5-24-0))
    :effect (and (not (at bad-5-24-0)) (at bad-6-72-1) (increase (total-cost) 1)))

  (:action a-bad-6-72-2
    :parameters ()
    :precondition (and (at bad-5-24-0))
    :effect (and (not (at bad-5-24-0)) (at bad-6-72-2) (increase (total-cost) 1)))

  (:action a-bad-6-73-0
    :parameters ()
    :precondition (and (at bad-5-24-1))
    :effect (and (not (at bad-5-24-1)) (at bad-6-73-0) (increase (total-cost) 1)))

  (:action a-bad-6-73-1
    :parameters ()
    :precondition (and (at bad-5-24-1))
    :effect (and (not (at bad-5-24-1)) (at bad-6-73-1) (increase (total-cost) 1)))

  (:action a-bad-6-73-2
    :parameters ()
    :precondition (and (at bad-5-24-1))
    :effect (and (not (at bad-5-24-1)) (at bad-6-73-2) (increase (total-cost) 1)))

  (:action a-bad-6-74-0
    :parameters ()
    :precondition (and (at bad-5-24-2))
    :effect (and (not (at bad-5-24-2)) (at bad-6-74-0) (increase (total-cost) 1)))

  (:action a-bad-6-74-1
    :parameters ()
    :precondition (and (at bad-5-24-2))
    :effect (and (not (at bad-5-24-2)) (at bad-6-74-1) (increase (total-cost) 1)))

  (:action a-bad-6-74-2
    :parameters ()
    :precondition (and (at bad-5-24-2))
    :effect (and (not (at bad-5-24-2)) (at bad-6-74-2) (increase (total-cost) 1)))

  (:action a-bad-6-75-0
    :parameters ()
    :precondition (and (at bad-5-25-0))
    :effect (and (not (at bad-5-25-0)) (at bad-6-75-0) (increase (total-cost) 1)))

  (:action a-bad-6-75-1
    :parameters ()
    :precondition (and (at bad-5-25-0))
    :effect (and (not (at bad-5-25-0)) (at bad-6-75-1) (increase (total-cost) 1)))

  (:action a-bad-6-75-2
    :parameters ()
    :precondition (and (at bad-5-25-0))
    :effect (and (not (at bad-5-25-0)) (at bad-6-75-2) (increase (total-cost) 1)))

  (:action a-bad-6-76-0
    :parameters ()
    :precondition (and (at bad-5-25-1))
    :effect (and (not (at bad-5-25-1)) (at bad-6-76-0) (increase (total-cost) 1)))

  (:action a-bad-6-76-1
    :parameters ()
    :precondition (and (at bad-5-25-1))
    :effect (and (not (at bad-5-25-1)) (at bad-6-76-1) (increase (total-cost) 1)))

  (:action a-bad-6-76-2
    :parameters ()
    :precondition (and (at bad-5-25-1))
    :effect (and (not (at bad-5-25-1)) (at bad-6-76-2) (increase (total-cost) 1)))

  (:action a-bad-6-77-0
    :parameters ()
    :precondition (and (at bad-5-25-2))
    :effect (and (not (at bad-5-25-2)) (at bad-6-77-0) (increase (total-cost) 1)))

  (:action a-bad-6-77-1
    :parameters ()
    :precondition (and (at bad-5-25-2))
    :effect (and (not (at bad-5-25-2)) (at bad-6-77-1) (increase (total-cost) 1)))

  (:action a-bad-6-77-2
    :parameters ()
    :precondition (and (at bad-5-25-2))
    :effect (and (not (at bad-5-25-2)) (at bad-6-77-2) (increase (total-cost) 1)))

  (:action a-bad-6-78-0
    :parameters ()
    :precondition (and (at bad-5-26-0))
    :effect (and (not (at bad-5-26-0)) (at bad-6-78-0) (increase (total-cost) 1)))

  (:action a-bad-6-78-1
    :parameters ()
    :precondition (and (at bad-5-26-0))
    :effect (and (not (at bad-5-26-0)) (at bad-6-78-1) (increase (total-cost) 1)))

  (:action a-bad-6-78-2
    :parameters ()
    :precondition (and (at bad-5-26-0))
    :effect (and (not (at bad-5-26-0)) (at bad-6-78-2) (increase (total-cost) 1)))

  (:action a-bad-6-79-0
    :parameters ()
    :precondition (and (at bad-5-26-1))
    :effect (and (not (at bad-5-26-1)) (at bad-6-79-0) (increase (total-cost) 1)))

  (:action a-bad-6-79-1
    :parameters ()
    :precondition (and (at bad-5-26-1))
    :effect (and (not (at bad-5-26-1)) (at bad-6-79-1) (increase (total-cost) 1)))

  (:action a-bad-6-79-2
    :parameters ()
    :precondition (and (at bad-5-26-1))
    :effect (and (not (at bad-5-26-1)) (at bad-6-79-2) (increase (total-cost) 1)))

  (:action a-bad-6-80-0
    :parameters ()
    :precondition (and (at bad-5-26-2))
    :effect (and (not (at bad-5-26-2)) (at bad-6-80-0) (increase (total-cost) 1)))

  (:action a-bad-6-80-1
    :parameters ()
    :precondition (and (at bad-5-26-2))
    :effect (and (not (at bad-5-26-2)) (at bad-6-80-1) (increase (total-cost) 1)))

  (:action a-bad-6-80-2
    :parameters ()
    :precondition (and (at bad-5-26-2))
    :effect (and (not (at bad-5-26-2)) (at bad-6-80-2) (increase (total-cost) 1)))

  (:action a-bad-6-81-0
    :parameters ()
    :precondition (and (at bad-5-27-0))
    :effect (and (not (at bad-5-27-0)) (at bad-6-81-0) (increase (total-cost) 1)))

  (:action a-bad-6-81-1
    :parameters ()
    :precondition (and (at bad-5-27-0))
    :effect (and (not (at bad-5-27-0)) (at bad-6-81-1) (increase (total-cost) 1)))

  (:action a-bad-6-81-2
    :parameters ()
    :precondition (and (at bad-5-27-0))
    :effect (and (not (at bad-5-27-0)) (at bad-6-81-2) (increase (total-cost) 1)))

  (:action a-bad-6-82-0
    :parameters ()
    :precondition (and (at bad-5-27-1))
    :effect (and (not (at bad-5-27-1)) (at bad-6-82-0) (increase (total-cost) 1)))

  (:action a-bad-6-82-1
    :parameters ()
    :precondition (and (at bad-5-27-1))
    :effect (and (not (at bad-5-27-1)) (at bad-6-82-1) (increase (total-cost) 1)))

  (:action a-bad-6-82-2
    :parameters ()
    :precondition (and (at bad-5-27-1))
    :effect (and (not (at bad-5-27-1)) (at bad-6-82-2) (increase (total-cost) 1)))

  (:action a-bad-6-83-0
    :parameters ()
    :precondition (and (at bad-5-27-2))
    :effect (and (not (at bad-5-27-2)) (at bad-6-83-0) (increase (total-cost) 1)))

  (:action a-bad-6-83-1
    :parameters ()
    :precondition (and (at bad-5-27-2))
    :effect (and (not (at bad-5-27-2)) (at bad-6-83-1) (increase (total-cost) 1)))

  (:action a-bad-6-83-2
    :parameters ()
    :precondition (and (at bad-5-27-2))
    :effect (and (not (at bad-5-27-2)) (at bad-6-83-2) (increase (total-cost) 1)))

  (:action a-bad-6-84-0
    :parameters ()
    :precondition (and (at bad-5-28-0))
    :effect (and (not (at bad-5-28-0)) (at bad-6-84-0) (increase (total-cost) 1)))

  (:action a-bad-6-84-1
    :parameters ()
    :precondition (and (at bad-5-28-0))
    :effect (and (not (at bad-5-28-0)) (at bad-6-84-1) (increase (total-cost) 1)))

  (:action a-bad-6-84-2
    :parameters ()
    :precondition (and (at bad-5-28-0))
    :effect (and (not (at bad-5-28-0)) (at bad-6-84-2) (increase (total-cost) 1)))

  (:action a-bad-6-85-0
    :parameters ()
    :precondition (and (at bad-5-28-1))
    :effect (and (not (at bad-5-28-1)) (at bad-6-85-0) (increase (total-cost) 1)))

  (:action a-bad-6-85-1
    :parameters ()
    :precondition (and (at bad-5-28-1))
    :effect (and (not (at bad-5-28-1)) (at bad-6-85-1) (increase (total-cost) 1)))

  (:action a-bad-6-85-2
    :parameters ()
    :precondition (and (at bad-5-28-1))
    :effect (and (not (at bad-5-28-1)) (at bad-6-85-2) (increase (total-cost) 1)))

  (:action a-bad-6-86-0
    :parameters ()
    :precondition (and (at bad-5-28-2))
    :effect (and (not (at bad-5-28-2)) (at bad-6-86-0) (increase (total-cost) 1)))

  (:action a-bad-6-86-1
    :parameters ()
    :precondition (and (at bad-5-28-2))
    :effect (and (not (at bad-5-28-2)) (at bad-6-86-1) (increase (total-cost) 1)))

  (:action a-bad-6-86-2
    :parameters ()
    :precondition (and (at bad-5-28-2))
    :effect (and (not (at bad-5-28-2)) (at bad-6-86-2) (increase (total-cost) 1)))

  (:action a-bad-6-87-0
    :parameters ()
    :precondition (and (at bad-5-29-0))
    :effect (and (not (at bad-5-29-0)) (at bad-6-87-0) (increase (total-cost) 1)))

  (:action a-bad-6-87-1
    :parameters ()
    :precondition (and (at bad-5-29-0))
    :effect (and (not (at bad-5-29-0)) (at bad-6-87-1) (increase (total-cost) 1)))

  (:action a-bad-6-87-2
    :parameters ()
    :precondition (and (at bad-5-29-0))
    :effect (and (not (at bad-5-29-0)) (at bad-6-87-2) (increase (total-cost) 1)))

  (:action a-bad-6-88-0
    :parameters ()
    :precondition (and (at bad-5-29-1))
    :effect (and (not (at bad-5-29-1)) (at bad-6-88-0) (increase (total-cost) 1)))

  (:action a-bad-6-88-1
    :parameters ()
    :precondition (and (at bad-5-29-1))
    :effect (and (not (at bad-5-29-1)) (at bad-6-88-1) (increase (total-cost) 1)))

  (:action a-bad-6-88-2
    :parameters ()
    :precondition (and (at bad-5-29-1))
    :effect (and (not (at bad-5-29-1)) (at bad-6-88-2) (increase (total-cost) 1)))

  (:action a-bad-6-89-0
    :parameters ()
    :precondition (and (at bad-5-29-2))
    :effect (and (not (at bad-5-29-2)) (at bad-6-89-0) (increase (total-cost) 1)))

  (:action a-bad-6-89-1
    :parameters ()
    :precondition (and (at bad-5-29-2))
    :effect (and (not (at bad-5-29-2)) (at bad-6-89-1) (increase (total-cost) 1)))

  (:action a-bad-6-89-2
    :parameters ()
    :precondition (and (at bad-5-29-2))
    :effect (and (not (at bad-5-29-2)) (at bad-6-89-2) (increase (total-cost) 1)))

  (:action a-bad-6-90-0
    :parameters ()
    :precondition (and (at bad-5-30-0))
    :effect (and (not (at bad-5-30-0)) (at bad-6-90-0) (increase (total-cost) 1)))

  (:action a-bad-6-90-1
    :parameters ()
    :precondition (and (at bad-5-30-0))
    :effect (and (not (at bad-5-30-0)) (at bad-6-90-1) (increase (total-cost) 1)))

  (:action a-bad-6-90-2
    :parameters ()
    :precondition (and (at bad-5-30-0))
    :effect (and (not (at bad-5-30-0)) (at bad-6-90-2) (increase (total-cost) 1)))

  (:action a-bad-6-91-0
    :parameters ()
    :precondition (and (at bad-5-30-1))
    :effect (and (not (at bad-5-30-1)) (at bad-6-91-0) (increase (total-cost) 1)))

  (:action a-bad-6-91-1
    :parameters ()
    :precondition (and (at bad-5-30-1))
    :effect (and (not (at bad-5-30-1)) (at bad-6-91-1) (increase (total-cost) 1)))

  (:action a-bad-6-91-2
    :parameters ()
    :precondition (and (at bad-5-30-1))
    :effect (and (not (at bad-5-30-1)) (at bad-6-91-2) (increase (total-cost) 1)))

  (:action a-bad-6-92-0
    :parameters ()
    :precondition (and (at bad-5-30-2))
    :effect (and (not (at bad-5-30-2)) (at bad-6-92-0) (increase (total-cost) 1)))

  (:action a-bad-6-92-1
    :parameters ()
    :precondition (and (at bad-5-30-2))
    :effect (and (not (at bad-5-30-2)) (at bad-6-92-1) (increase (total-cost) 1)))

  (:action a-bad-6-92-2
    :parameters ()
    :precondition (and (at bad-5-30-2))
    :effect (and (not (at bad-5-30-2)) (at bad-6-92-2) (increase (total-cost) 1)))

  (:action a-bad-6-93-0
    :parameters ()
    :precondition (and (at bad-5-31-0))
    :effect (and (not (at bad-5-31-0)) (at bad-6-93-0) (increase (total-cost) 1)))

  (:action a-bad-6-93-1
    :parameters ()
    :precondition (and (at bad-5-31-0))
    :effect (and (not (at bad-5-31-0)) (at bad-6-93-1) (increase (total-cost) 1)))

  (:action a-bad-6-93-2
    :parameters ()
    :precondition (and (at bad-5-31-0))
    :effect (and (not (at bad-5-31-0)) (at bad-6-93-2) (increase (total-cost) 1)))

  (:action a-bad-6-94-0
    :parameters ()
    :precondition (and (at bad-5-31-1))
    :effect (and (not (at bad-5-31-1)) (at bad-6-94-0) (increase (total-cost) 1)))

  (:action a-bad-6-94-1
    :parameters ()
    :precondition (and (at bad-5-31-1))
    :effect (and (not (at bad-5-31-1)) (at bad-6-94-1) (increase (total-cost) 1)))

  (:action a-bad-6-94-2
    :parameters ()
    :precondition (and (at bad-5-31-1))
    :effect (and (not (at bad-5-31-1)) (at bad-6-94-2) (increase (total-cost) 1)))

  (:action a-bad-6-95-0
    :parameters ()
    :precondition (and (at bad-5-31-2))
    :effect (and (not (at bad-5-31-2)) (at bad-6-95-0) (increase (total-cost) 1)))

  (:action a-bad-6-95-1
    :parameters ()
    :precondition (and (at bad-5-31-2))
    :effect (and (not (at bad-5-31-2)) (at bad-6-95-1) (increase (total-cost) 1)))

  (:action a-bad-6-95-2
    :parameters ()
    :precondition (and (at bad-5-31-2))
    :effect (and (not (at bad-5-31-2)) (at bad-6-95-2) (increase (total-cost) 1)))

  (:action a-bad-6-96-0
    :parameters ()
    :precondition (and (at bad-5-32-0))
    :effect (and (not (at bad-5-32-0)) (at bad-6-96-0) (increase (total-cost) 1)))

  (:action a-bad-6-96-1
    :parameters ()
    :precondition (and (at bad-5-32-0))
    :effect (and (not (at bad-5-32-0)) (at bad-6-96-1) (increase (total-cost) 1)))

  (:action a-bad-6-96-2
    :parameters ()
    :precondition (and (at bad-5-32-0))
    :effect (and (not (at bad-5-32-0)) (at bad-6-96-2) (increase (total-cost) 1)))

  (:action a-bad-6-97-0
    :parameters ()
    :precondition (and (at bad-5-32-1))
    :effect (and (not (at bad-5-32-1)) (at bad-6-97-0) (increase (total-cost) 1)))

  (:action a-bad-6-97-1
    :parameters ()
    :precondition (and (at bad-5-32-1))
    :effect (and (not (at bad-5-32-1)) (at bad-6-97-1) (increase (total-cost) 1)))

  (:action a-bad-6-97-2
    :parameters ()
    :precondition (and (at bad-5-32-1))
    :effect (and (not (at bad-5-32-1)) (at bad-6-97-2) (increase (total-cost) 1)))

  (:action a-bad-6-98-0
    :parameters ()
    :precondition (and (at bad-5-32-2))
    :effect (and (not (at bad-5-32-2)) (at bad-6-98-0) (increase (total-cost) 1)))

  (:action a-bad-6-98-1
    :parameters ()
    :precondition (and (at bad-5-32-2))
    :effect (and (not (at bad-5-32-2)) (at bad-6-98-1) (increase (total-cost) 1)))

  (:action a-bad-6-98-2
    :parameters ()
    :precondition (and (at bad-5-32-2))
    :effect (and (not (at bad-5-32-2)) (at bad-6-98-2) (increase (total-cost) 1)))

  (:action a-bad-6-99-0
    :parameters ()
    :precondition (and (at bad-5-33-0))
    :effect (and (not (at bad-5-33-0)) (at bad-6-99-0) (increase (total-cost) 1)))

  (:action a-bad-6-99-1
    :parameters ()
    :precondition (and (at bad-5-33-0))
    :effect (and (not (at bad-5-33-0)) (at bad-6-99-1) (increase (total-cost) 1)))

  (:action a-bad-6-99-2
    :parameters ()
    :precondition (and (at bad-5-33-0))
    :effect (and (not (at bad-5-33-0)) (at bad-6-99-2) (increase (total-cost) 1)))

  (:action a-bad-6-100-0
    :parameters ()
    :precondition (and (at bad-5-33-1))
    :effect (and (not (at bad-5-33-1)) (at bad-6-100-0) (increase (total-cost) 1)))

  (:action a-bad-6-100-1
    :parameters ()
    :precondition (and (at bad-5-33-1))
    :effect (and (not (at bad-5-33-1)) (at bad-6-100-1) (increase (total-cost) 1)))

  (:action a-bad-6-100-2
    :parameters ()
    :precondition (and (at bad-5-33-1))
    :effect (and (not (at bad-5-33-1)) (at bad-6-100-2) (increase (total-cost) 1)))

  (:action a-bad-6-101-0
    :parameters ()
    :precondition (and (at bad-5-33-2))
    :effect (and (not (at bad-5-33-2)) (at bad-6-101-0) (increase (total-cost) 1)))

  (:action a-bad-6-101-1
    :parameters ()
    :precondition (and (at bad-5-33-2))
    :effect (and (not (at bad-5-33-2)) (at bad-6-101-1) (increase (total-cost) 1)))

  (:action a-bad-6-101-2
    :parameters ()
    :precondition (and (at bad-5-33-2))
    :effect (and (not (at bad-5-33-2)) (at bad-6-101-2) (increase (total-cost) 1)))

  (:action a-bad-6-102-0
    :parameters ()
    :precondition (and (at bad-5-34-0))
    :effect (and (not (at bad-5-34-0)) (at bad-6-102-0) (increase (total-cost) 1)))

  (:action a-bad-6-102-1
    :parameters ()
    :precondition (and (at bad-5-34-0))
    :effect (and (not (at bad-5-34-0)) (at bad-6-102-1) (increase (total-cost) 1)))

  (:action a-bad-6-102-2
    :parameters ()
    :precondition (and (at bad-5-34-0))
    :effect (and (not (at bad-5-34-0)) (at bad-6-102-2) (increase (total-cost) 1)))

  (:action a-bad-6-103-0
    :parameters ()
    :precondition (and (at bad-5-34-1))
    :effect (and (not (at bad-5-34-1)) (at bad-6-103-0) (increase (total-cost) 1)))

  (:action a-bad-6-103-1
    :parameters ()
    :precondition (and (at bad-5-34-1))
    :effect (and (not (at bad-5-34-1)) (at bad-6-103-1) (increase (total-cost) 1)))

  (:action a-bad-6-103-2
    :parameters ()
    :precondition (and (at bad-5-34-1))
    :effect (and (not (at bad-5-34-1)) (at bad-6-103-2) (increase (total-cost) 1)))

  (:action a-bad-6-104-0
    :parameters ()
    :precondition (and (at bad-5-34-2))
    :effect (and (not (at bad-5-34-2)) (at bad-6-104-0) (increase (total-cost) 1)))

  (:action a-bad-6-104-1
    :parameters ()
    :precondition (and (at bad-5-34-2))
    :effect (and (not (at bad-5-34-2)) (at bad-6-104-1) (increase (total-cost) 1)))

  (:action a-bad-6-104-2
    :parameters ()
    :precondition (and (at bad-5-34-2))
    :effect (and (not (at bad-5-34-2)) (at bad-6-104-2) (increase (total-cost) 1)))

  (:action a-bad-6-105-0
    :parameters ()
    :precondition (and (at bad-5-35-0))
    :effect (and (not (at bad-5-35-0)) (at bad-6-105-0) (increase (total-cost) 1)))

  (:action a-bad-6-105-1
    :parameters ()
    :precondition (and (at bad-5-35-0))
    :effect (and (not (at bad-5-35-0)) (at bad-6-105-1) (increase (total-cost) 1)))

  (:action a-bad-6-105-2
    :parameters ()
    :precondition (and (at bad-5-35-0))
    :effect (and (not (at bad-5-35-0)) (at bad-6-105-2) (increase (total-cost) 1)))

  (:action a-bad-6-106-0
    :parameters ()
    :precondition (and (at bad-5-35-1))
    :effect (and (not (at bad-5-35-1)) (at bad-6-106-0) (increase (total-cost) 1)))

  (:action a-bad-6-106-1
    :parameters ()
    :precondition (and (at bad-5-35-1))
    :effect (and (not (at bad-5-35-1)) (at bad-6-106-1) (increase (total-cost) 1)))

  (:action a-bad-6-106-2
    :parameters ()
    :precondition (and (at bad-5-35-1))
    :effect (and (not (at bad-5-35-1)) (at bad-6-106-2) (increase (total-cost) 1)))

  (:action a-bad-6-107-0
    :parameters ()
    :precondition (and (at bad-5-35-2))
    :effect (and (not (at bad-5-35-2)) (at bad-6-107-0) (increase (total-cost) 1)))

  (:action a-bad-6-107-1
    :parameters ()
    :precondition (and (at bad-5-35-2))
    :effect (and (not (at bad-5-35-2)) (at bad-6-107-1) (increase (total-cost) 1)))

  (:action a-bad-6-107-2
    :parameters ()
    :precondition (and (at bad-5-35-2))
    :effect (and (not (at bad-5-35-2)) (at bad-6-107-2) (increase (total-cost) 1)))

  (:action a-bad-6-108-0
    :parameters ()
    :precondition (and (at bad-5-36-0))
    :effect (and (not (at bad-5-36-0)) (at bad-6-108-0) (increase (total-cost) 1)))

  (:action a-bad-6-108-1
    :parameters ()
    :precondition (and (at bad-5-36-0))
    :effect (and (not (at bad-5-36-0)) (at bad-6-108-1) (increase (total-cost) 1)))

  (:action a-bad-6-108-2
    :parameters ()
    :precondition (and (at bad-5-36-0))
    :effect (and (not (at bad-5-36-0)) (at bad-6-108-2) (increase (total-cost) 1)))

  (:action a-bad-6-109-0
    :parameters ()
    :precondition (and (at bad-5-36-1))
    :effect (and (not (at bad-5-36-1)) (at bad-6-109-0) (increase (total-cost) 1)))

  (:action a-bad-6-109-1
    :parameters ()
    :precondition (and (at bad-5-36-1))
    :effect (and (not (at bad-5-36-1)) (at bad-6-109-1) (increase (total-cost) 1)))

  (:action a-bad-6-109-2
    :parameters ()
    :precondition (and (at bad-5-36-1))
    :effect (and (not (at bad-5-36-1)) (at bad-6-109-2) (increase (total-cost) 1)))

  (:action a-bad-6-110-0
    :parameters ()
    :precondition (and (at bad-5-36-2))
    :effect (and (not (at bad-5-36-2)) (at bad-6-110-0) (increase (total-cost) 1)))

  (:action a-bad-6-110-1
    :parameters ()
    :precondition (and (at bad-5-36-2))
    :effect (and (not (at bad-5-36-2)) (at bad-6-110-1) (increase (total-cost) 1)))

  (:action a-bad-6-110-2
    :parameters ()
    :precondition (and (at bad-5-36-2))
    :effect (and (not (at bad-5-36-2)) (at bad-6-110-2) (increase (total-cost) 1)))

  (:action a-bad-6-111-0
    :parameters ()
    :precondition (and (at bad-5-37-0))
    :effect (and (not (at bad-5-37-0)) (at bad-6-111-0) (increase (total-cost) 1)))

  (:action a-bad-6-111-1
    :parameters ()
    :precondition (and (at bad-5-37-0))
    :effect (and (not (at bad-5-37-0)) (at bad-6-111-1) (increase (total-cost) 1)))

  (:action a-bad-6-111-2
    :parameters ()
    :precondition (and (at bad-5-37-0))
    :effect (and (not (at bad-5-37-0)) (at bad-6-111-2) (increase (total-cost) 1)))

  (:action a-bad-6-112-0
    :parameters ()
    :precondition (and (at bad-5-37-1))
    :effect (and (not (at bad-5-37-1)) (at bad-6-112-0) (increase (total-cost) 1)))

  (:action a-bad-6-112-1
    :parameters ()
    :precondition (and (at bad-5-37-1))
    :effect (and (not (at bad-5-37-1)) (at bad-6-112-1) (increase (total-cost) 1)))

  (:action a-bad-6-112-2
    :parameters ()
    :precondition (and (at bad-5-37-1))
    :effect (and (not (at bad-5-37-1)) (at bad-6-112-2) (increase (total-cost) 1)))

  (:action a-bad-6-113-0
    :parameters ()
    :precondition (and (at bad-5-37-2))
    :effect (and (not (at bad-5-37-2)) (at bad-6-113-0) (increase (total-cost) 1)))

  (:action a-bad-6-113-1
    :parameters ()
    :precondition (and (at bad-5-37-2))
    :effect (and (not (at bad-5-37-2)) (at bad-6-113-1) (increase (total-cost) 1)))

  (:action a-bad-6-113-2
    :parameters ()
    :precondition (and (at bad-5-37-2))
    :effect (and (not (at bad-5-37-2)) (at bad-6-113-2) (increase (total-cost) 1)))

  (:action a-bad-6-114-0
    :parameters ()
    :precondition (and (at bad-5-38-0))
    :effect (and (not (at bad-5-38-0)) (at bad-6-114-0) (increase (total-cost) 1)))

  (:action a-bad-6-114-1
    :parameters ()
    :precondition (and (at bad-5-38-0))
    :effect (and (not (at bad-5-38-0)) (at bad-6-114-1) (increase (total-cost) 1)))

  (:action a-bad-6-114-2
    :parameters ()
    :precondition (and (at bad-5-38-0))
    :effect (and (not (at bad-5-38-0)) (at bad-6-114-2) (increase (total-cost) 1)))

  (:action a-bad-6-115-0
    :parameters ()
    :precondition (and (at bad-5-38-1))
    :effect (and (not (at bad-5-38-1)) (at bad-6-115-0) (increase (total-cost) 1)))

  (:action a-bad-6-115-1
    :parameters ()
    :precondition (and (at bad-5-38-1))
    :effect (and (not (at bad-5-38-1)) (at bad-6-115-1) (increase (total-cost) 1)))

  (:action a-bad-6-115-2
    :parameters ()
    :precondition (and (at bad-5-38-1))
    :effect (and (not (at bad-5-38-1)) (at bad-6-115-2) (increase (total-cost) 1)))

  (:action a-bad-6-116-0
    :parameters ()
    :precondition (and (at bad-5-38-2))
    :effect (and (not (at bad-5-38-2)) (at bad-6-116-0) (increase (total-cost) 1)))

  (:action a-bad-6-116-1
    :parameters ()
    :precondition (and (at bad-5-38-2))
    :effect (and (not (at bad-5-38-2)) (at bad-6-116-1) (increase (total-cost) 1)))

  (:action a-bad-6-116-2
    :parameters ()
    :precondition (and (at bad-5-38-2))
    :effect (and (not (at bad-5-38-2)) (at bad-6-116-2) (increase (total-cost) 1)))

  (:action a-bad-6-117-0
    :parameters ()
    :precondition (and (at bad-5-39-0))
    :effect (and (not (at bad-5-39-0)) (at bad-6-117-0) (increase (total-cost) 1)))

  (:action a-bad-6-117-1
    :parameters ()
    :precondition (and (at bad-5-39-0))
    :effect (and (not (at bad-5-39-0)) (at bad-6-117-1) (increase (total-cost) 1)))

  (:action a-bad-6-117-2
    :parameters ()
    :precondition (and (at bad-5-39-0))
    :effect (and (not (at bad-5-39-0)) (at bad-6-117-2) (increase (total-cost) 1)))

  (:action a-bad-6-118-0
    :parameters ()
    :precondition (and (at bad-5-39-1))
    :effect (and (not (at bad-5-39-1)) (at bad-6-118-0) (increase (total-cost) 1)))

  (:action a-bad-6-118-1
    :parameters ()
    :precondition (and (at bad-5-39-1))
    :effect (and (not (at bad-5-39-1)) (at bad-6-118-1) (increase (total-cost) 1)))

  (:action a-bad-6-118-2
    :parameters ()
    :precondition (and (at bad-5-39-1))
    :effect (and (not (at bad-5-39-1)) (at bad-6-118-2) (increase (total-cost) 1)))

  (:action a-bad-6-119-0
    :parameters ()
    :precondition (and (at bad-5-39-2))
    :effect (and (not (at bad-5-39-2)) (at bad-6-119-0) (increase (total-cost) 1)))

  (:action a-bad-6-119-1
    :parameters ()
    :precondition (and (at bad-5-39-2))
    :effect (and (not (at bad-5-39-2)) (at bad-6-119-1) (increase (total-cost) 1)))

  (:action a-bad-6-119-2
    :parameters ()
    :precondition (and (at bad-5-39-2))
    :effect (and (not (at bad-5-39-2)) (at bad-6-119-2) (increase (total-cost) 1)))

  (:action a-bad-6-120-0
    :parameters ()
    :precondition (and (at bad-5-40-0))
    :effect (and (not (at bad-5-40-0)) (at bad-6-120-0) (increase (total-cost) 1)))

  (:action a-bad-6-120-1
    :parameters ()
    :precondition (and (at bad-5-40-0))
    :effect (and (not (at bad-5-40-0)) (at bad-6-120-1) (increase (total-cost) 1)))

  (:action a-bad-6-120-2
    :parameters ()
    :precondition (and (at bad-5-40-0))
    :effect (and (not (at bad-5-40-0)) (at bad-6-120-2) (increase (total-cost) 1)))

  (:action a-bad-6-121-0
    :parameters ()
    :precondition (and (at bad-5-40-1))
    :effect (and (not (at bad-5-40-1)) (at bad-6-121-0) (increase (total-cost) 1)))

  (:action a-bad-6-121-1
    :parameters ()
    :precondition (and (at bad-5-40-1))
    :effect (and (not (at bad-5-40-1)) (at bad-6-121-1) (increase (total-cost) 1)))

  (:action a-bad-6-121-2
    :parameters ()
    :precondition (and (at bad-5-40-1))
    :effect (and (not (at bad-5-40-1)) (at bad-6-121-2) (increase (total-cost) 1)))

  (:action a-bad-6-122-0
    :parameters ()
    :precondition (and (at bad-5-40-2))
    :effect (and (not (at bad-5-40-2)) (at bad-6-122-0) (increase (total-cost) 1)))

  (:action a-bad-6-122-1
    :parameters ()
    :precondition (and (at bad-5-40-2))
    :effect (and (not (at bad-5-40-2)) (at bad-6-122-1) (increase (total-cost) 1)))

  (:action a-bad-6-122-2
    :parameters ()
    :precondition (and (at bad-5-40-2))
    :effect (and (not (at bad-5-40-2)) (at bad-6-122-2) (increase (total-cost) 1)))

  (:action a-bad-6-123-0
    :parameters ()
    :precondition (and (at bad-5-41-0))
    :effect (and (not (at bad-5-41-0)) (at bad-6-123-0) (increase (total-cost) 1)))

  (:action a-bad-6-123-1
    :parameters ()
    :precondition (and (at bad-5-41-0))
    :effect (and (not (at bad-5-41-0)) (at bad-6-123-1) (increase (total-cost) 1)))

  (:action a-bad-6-123-2
    :parameters ()
    :precondition (and (at bad-5-41-0))
    :effect (and (not (at bad-5-41-0)) (at bad-6-123-2) (increase (total-cost) 1)))

  (:action a-bad-6-124-0
    :parameters ()
    :precondition (and (at bad-5-41-1))
    :effect (and (not (at bad-5-41-1)) (at bad-6-124-0) (increase (total-cost) 1)))

  (:action a-bad-6-124-1
    :parameters ()
    :precondition (and (at bad-5-41-1))
    :effect (and (not (at bad-5-41-1)) (at bad-6-124-1) (increase (total-cost) 1)))

  (:action a-bad-6-124-2
    :parameters ()
    :precondition (and (at bad-5-41-1))
    :effect (and (not (at bad-5-41-1)) (at bad-6-124-2) (increase (total-cost) 1)))

  (:action a-bad-6-125-0
    :parameters ()
    :precondition (and (at bad-5-41-2))
    :effect (and (not (at bad-5-41-2)) (at bad-6-125-0) (increase (total-cost) 1)))

  (:action a-bad-6-125-1
    :parameters ()
    :precondition (and (at bad-5-41-2))
    :effect (and (not (at bad-5-41-2)) (at bad-6-125-1) (increase (total-cost) 1)))

  (:action a-bad-6-125-2
    :parameters ()
    :precondition (and (at bad-5-41-2))
    :effect (and (not (at bad-5-41-2)) (at bad-6-125-2) (increase (total-cost) 1)))

  (:action a-bad-6-126-0
    :parameters ()
    :precondition (and (at bad-5-42-0))
    :effect (and (not (at bad-5-42-0)) (at bad-6-126-0) (increase (total-cost) 1)))

  (:action a-bad-6-126-1
    :parameters ()
    :precondition (and (at bad-5-42-0))
    :effect (and (not (at bad-5-42-0)) (at bad-6-126-1) (increase (total-cost) 1)))

  (:action a-bad-6-126-2
    :parameters ()
    :precondition (and (at bad-5-42-0))
    :effect (and (not (at bad-5-42-0)) (at bad-6-126-2) (increase (total-cost) 1)))

  (:action a-bad-6-127-0
    :parameters ()
    :precondition (and (at bad-5-42-1))
    :effect (and (not (at bad-5-42-1)) (at bad-6-127-0) (increase (total-cost) 1)))

  (:action a-bad-6-127-1
    :parameters ()
    :precondition (and (at bad-5-42-1))
    :effect (and (not (at bad-5-42-1)) (at bad-6-127-1) (increase (total-cost) 1)))

  (:action a-bad-6-127-2
    :parameters ()
    :precondition (and (at bad-5-42-1))
    :effect (and (not (at bad-5-42-1)) (at bad-6-127-2) (increase (total-cost) 1)))

  (:action a-bad-6-128-0
    :parameters ()
    :precondition (and (at bad-5-42-2))
    :effect (and (not (at bad-5-42-2)) (at bad-6-128-0) (increase (total-cost) 1)))

  (:action a-bad-6-128-1
    :parameters ()
    :precondition (and (at bad-5-42-2))
    :effect (and (not (at bad-5-42-2)) (at bad-6-128-1) (increase (total-cost) 1)))

  (:action a-bad-6-128-2
    :parameters ()
    :precondition (and (at bad-5-42-2))
    :effect (and (not (at bad-5-42-2)) (at bad-6-128-2) (increase (total-cost) 1)))

  (:action a-bad-6-129-0
    :parameters ()
    :precondition (and (at bad-5-43-0))
    :effect (and (not (at bad-5-43-0)) (at bad-6-129-0) (increase (total-cost) 1)))

  (:action a-bad-6-129-1
    :parameters ()
    :precondition (and (at bad-5-43-0))
    :effect (and (not (at bad-5-43-0)) (at bad-6-129-1) (increase (total-cost) 1)))

  (:action a-bad-6-129-2
    :parameters ()
    :precondition (and (at bad-5-43-0))
    :effect (and (not (at bad-5-43-0)) (at bad-6-129-2) (increase (total-cost) 1)))

  (:action a-bad-6-130-0
    :parameters ()
    :precondition (and (at bad-5-43-1))
    :effect (and (not (at bad-5-43-1)) (at bad-6-130-0) (increase (total-cost) 1)))

  (:action a-bad-6-130-1
    :parameters ()
    :precondition (and (at bad-5-43-1))
    :effect (and (not (at bad-5-43-1)) (at bad-6-130-1) (increase (total-cost) 1)))

  (:action a-bad-6-130-2
    :parameters ()
    :precondition (and (at bad-5-43-1))
    :effect (and (not (at bad-5-43-1)) (at bad-6-130-2) (increase (total-cost) 1)))

  (:action a-bad-6-131-0
    :parameters ()
    :precondition (and (at bad-5-43-2))
    :effect (and (not (at bad-5-43-2)) (at bad-6-131-0) (increase (total-cost) 1)))

  (:action a-bad-6-131-1
    :parameters ()
    :precondition (and (at bad-5-43-2))
    :effect (and (not (at bad-5-43-2)) (at bad-6-131-1) (increase (total-cost) 1)))

  (:action a-bad-6-131-2
    :parameters ()
    :precondition (and (at bad-5-43-2))
    :effect (and (not (at bad-5-43-2)) (at bad-6-131-2) (increase (total-cost) 1)))

  (:action a-bad-6-132-0
    :parameters ()
    :precondition (and (at bad-5-44-0))
    :effect (and (not (at bad-5-44-0)) (at bad-6-132-0) (increase (total-cost) 1)))

  (:action a-bad-6-132-1
    :parameters ()
    :precondition (and (at bad-5-44-0))
    :effect (and (not (at bad-5-44-0)) (at bad-6-132-1) (increase (total-cost) 1)))

  (:action a-bad-6-132-2
    :parameters ()
    :precondition (and (at bad-5-44-0))
    :effect (and (not (at bad-5-44-0)) (at bad-6-132-2) (increase (total-cost) 1)))

  (:action a-bad-6-133-0
    :parameters ()
    :precondition (and (at bad-5-44-1))
    :effect (and (not (at bad-5-44-1)) (at bad-6-133-0) (increase (total-cost) 1)))

  (:action a-bad-6-133-1
    :parameters ()
    :precondition (and (at bad-5-44-1))
    :effect (and (not (at bad-5-44-1)) (at bad-6-133-1) (increase (total-cost) 1)))

  (:action a-bad-6-133-2
    :parameters ()
    :precondition (and (at bad-5-44-1))
    :effect (and (not (at bad-5-44-1)) (at bad-6-133-2) (increase (total-cost) 1)))

  (:action a-bad-6-134-0
    :parameters ()
    :precondition (and (at bad-5-44-2))
    :effect (and (not (at bad-5-44-2)) (at bad-6-134-0) (increase (total-cost) 1)))

  (:action a-bad-6-134-1
    :parameters ()
    :precondition (and (at bad-5-44-2))
    :effect (and (not (at bad-5-44-2)) (at bad-6-134-1) (increase (total-cost) 1)))

  (:action a-bad-6-134-2
    :parameters ()
    :precondition (and (at bad-5-44-2))
    :effect (and (not (at bad-5-44-2)) (at bad-6-134-2) (increase (total-cost) 1)))

  (:action a-bad-6-135-0
    :parameters ()
    :precondition (and (at bad-5-45-0))
    :effect (and (not (at bad-5-45-0)) (at bad-6-135-0) (increase (total-cost) 1)))

  (:action a-bad-6-135-1
    :parameters ()
    :precondition (and (at bad-5-45-0))
    :effect (and (not (at bad-5-45-0)) (at bad-6-135-1) (increase (total-cost) 1)))

  (:action a-bad-6-135-2
    :parameters ()
    :precondition (and (at bad-5-45-0))
    :effect (and (not (at bad-5-45-0)) (at bad-6-135-2) (increase (total-cost) 1)))

  (:action a-bad-6-136-0
    :parameters ()
    :precondition (and (at bad-5-45-1))
    :effect (and (not (at bad-5-45-1)) (at bad-6-136-0) (increase (total-cost) 1)))

  (:action a-bad-6-136-1
    :parameters ()
    :precondition (and (at bad-5-45-1))
    :effect (and (not (at bad-5-45-1)) (at bad-6-136-1) (increase (total-cost) 1)))

  (:action a-bad-6-136-2
    :parameters ()
    :precondition (and (at bad-5-45-1))
    :effect (and (not (at bad-5-45-1)) (at bad-6-136-2) (increase (total-cost) 1)))

  (:action a-bad-6-137-0
    :parameters ()
    :precondition (and (at bad-5-45-2))
    :effect (and (not (at bad-5-45-2)) (at bad-6-137-0) (increase (total-cost) 1)))

  (:action a-bad-6-137-1
    :parameters ()
    :precondition (and (at bad-5-45-2))
    :effect (and (not (at bad-5-45-2)) (at bad-6-137-1) (increase (total-cost) 1)))

  (:action a-bad-6-137-2
    :parameters ()
    :precondition (and (at bad-5-45-2))
    :effect (and (not (at bad-5-45-2)) (at bad-6-137-2) (increase (total-cost) 1)))

  (:action a-bad-6-138-0
    :parameters ()
    :precondition (and (at bad-5-46-0))
    :effect (and (not (at bad-5-46-0)) (at bad-6-138-0) (increase (total-cost) 1)))

  (:action a-bad-6-138-1
    :parameters ()
    :precondition (and (at bad-5-46-0))
    :effect (and (not (at bad-5-46-0)) (at bad-6-138-1) (increase (total-cost) 1)))

  (:action a-bad-6-138-2
    :parameters ()
    :precondition (and (at bad-5-46-0))
    :effect (and (not (at bad-5-46-0)) (at bad-6-138-2) (increase (total-cost) 1)))

  (:action a-bad-6-139-0
    :parameters ()
    :precondition (and (at bad-5-46-1))
    :effect (and (not (at bad-5-46-1)) (at bad-6-139-0) (increase (total-cost) 1)))

  (:action a-bad-6-139-1
    :parameters ()
    :precondition (and (at bad-5-46-1))
    :effect (and (not (at bad-5-46-1)) (at bad-6-139-1) (increase (total-cost) 1)))

  (:action a-bad-6-139-2
    :parameters ()
    :precondition (and (at bad-5-46-1))
    :effect (and (not (at bad-5-46-1)) (at bad-6-139-2) (increase (total-cost) 1)))

  (:action a-bad-6-140-0
    :parameters ()
    :precondition (and (at bad-5-46-2))
    :effect (and (not (at bad-5-46-2)) (at bad-6-140-0) (increase (total-cost) 1)))

  (:action a-bad-6-140-1
    :parameters ()
    :precondition (and (at bad-5-46-2))
    :effect (and (not (at bad-5-46-2)) (at bad-6-140-1) (increase (total-cost) 1)))

  (:action a-bad-6-140-2
    :parameters ()
    :precondition (and (at bad-5-46-2))
    :effect (and (not (at bad-5-46-2)) (at bad-6-140-2) (increase (total-cost) 1)))

  (:action a-bad-6-141-0
    :parameters ()
    :precondition (and (at bad-5-47-0))
    :effect (and (not (at bad-5-47-0)) (at bad-6-141-0) (increase (total-cost) 1)))

  (:action a-bad-6-141-1
    :parameters ()
    :precondition (and (at bad-5-47-0))
    :effect (and (not (at bad-5-47-0)) (at bad-6-141-1) (increase (total-cost) 1)))

  (:action a-bad-6-141-2
    :parameters ()
    :precondition (and (at bad-5-47-0))
    :effect (and (not (at bad-5-47-0)) (at bad-6-141-2) (increase (total-cost) 1)))

  (:action a-bad-6-142-0
    :parameters ()
    :precondition (and (at bad-5-47-1))
    :effect (and (not (at bad-5-47-1)) (at bad-6-142-0) (increase (total-cost) 1)))

  (:action a-bad-6-142-1
    :parameters ()
    :precondition (and (at bad-5-47-1))
    :effect (and (not (at bad-5-47-1)) (at bad-6-142-1) (increase (total-cost) 1)))

  (:action a-bad-6-142-2
    :parameters ()
    :precondition (and (at bad-5-47-1))
    :effect (and (not (at bad-5-47-1)) (at bad-6-142-2) (increase (total-cost) 1)))

  (:action a-bad-6-143-0
    :parameters ()
    :precondition (and (at bad-5-47-2))
    :effect (and (not (at bad-5-47-2)) (at bad-6-143-0) (increase (total-cost) 1)))

  (:action a-bad-6-143-1
    :parameters ()
    :precondition (and (at bad-5-47-2))
    :effect (and (not (at bad-5-47-2)) (at bad-6-143-1) (increase (total-cost) 1)))

  (:action a-bad-6-143-2
    :parameters ()
    :precondition (and (at bad-5-47-2))
    :effect (and (not (at bad-5-47-2)) (at bad-6-143-2) (increase (total-cost) 1)))

  (:action a-bad-6-144-0
    :parameters ()
    :precondition (and (at bad-5-48-0))
    :effect (and (not (at bad-5-48-0)) (at bad-6-144-0) (increase (total-cost) 1)))

  (:action a-bad-6-144-1
    :parameters ()
    :precondition (and (at bad-5-48-0))
    :effect (and (not (at bad-5-48-0)) (at bad-6-144-1) (increase (total-cost) 1)))

  (:action a-bad-6-144-2
    :parameters ()
    :precondition (and (at bad-5-48-0))
    :effect (and (not (at bad-5-48-0)) (at bad-6-144-2) (increase (total-cost) 1)))

  (:action a-bad-6-145-0
    :parameters ()
    :precondition (and (at bad-5-48-1))
    :effect (and (not (at bad-5-48-1)) (at bad-6-145-0) (increase (total-cost) 1)))

  (:action a-bad-6-145-1
    :parameters ()
    :precondition (and (at bad-5-48-1))
    :effect (and (not (at bad-5-48-1)) (at bad-6-145-1) (increase (total-cost) 1)))

  (:action a-bad-6-145-2
    :parameters ()
    :precondition (and (at bad-5-48-1))
    :effect (and (not (at bad-5-48-1)) (at bad-6-145-2) (increase (total-cost) 1)))

  (:action a-bad-6-146-0
    :parameters ()
    :precondition (and (at bad-5-48-2))
    :effect (and (not (at bad-5-48-2)) (at bad-6-146-0) (increase (total-cost) 1)))

  (:action a-bad-6-146-1
    :parameters ()
    :precondition (and (at bad-5-48-2))
    :effect (and (not (at bad-5-48-2)) (at bad-6-146-1) (increase (total-cost) 1)))

  (:action a-bad-6-146-2
    :parameters ()
    :precondition (and (at bad-5-48-2))
    :effect (and (not (at bad-5-48-2)) (at bad-6-146-2) (increase (total-cost) 1)))

  (:action a-bad-6-147-0
    :parameters ()
    :precondition (and (at bad-5-49-0))
    :effect (and (not (at bad-5-49-0)) (at bad-6-147-0) (increase (total-cost) 1)))

  (:action a-bad-6-147-1
    :parameters ()
    :precondition (and (at bad-5-49-0))
    :effect (and (not (at bad-5-49-0)) (at bad-6-147-1) (increase (total-cost) 1)))

  (:action a-bad-6-147-2
    :parameters ()
    :precondition (and (at bad-5-49-0))
    :effect (and (not (at bad-5-49-0)) (at bad-6-147-2) (increase (total-cost) 1)))

  (:action a-bad-6-148-0
    :parameters ()
    :precondition (and (at bad-5-49-1))
    :effect (and (not (at bad-5-49-1)) (at bad-6-148-0) (increase (total-cost) 1)))

  (:action a-bad-6-148-1
    :parameters ()
    :precondition (and (at bad-5-49-1))
    :effect (and (not (at bad-5-49-1)) (at bad-6-148-1) (increase (total-cost) 1)))

  (:action a-bad-6-148-2
    :parameters ()
    :precondition (and (at bad-5-49-1))
    :effect (and (not (at bad-5-49-1)) (at bad-6-148-2) (increase (total-cost) 1)))

  (:action a-bad-6-149-0
    :parameters ()
    :precondition (and (at bad-5-49-2))
    :effect (and (not (at bad-5-49-2)) (at bad-6-149-0) (increase (total-cost) 1)))

  (:action a-bad-6-149-1
    :parameters ()
    :precondition (and (at bad-5-49-2))
    :effect (and (not (at bad-5-49-2)) (at bad-6-149-1) (increase (total-cost) 1)))

  (:action a-bad-6-149-2
    :parameters ()
    :precondition (and (at bad-5-49-2))
    :effect (and (not (at bad-5-49-2)) (at bad-6-149-2) (increase (total-cost) 1)))

  (:action a-bad-6-150-0
    :parameters ()
    :precondition (and (at bad-5-50-0))
    :effect (and (not (at bad-5-50-0)) (at bad-6-150-0) (increase (total-cost) 1)))

  (:action a-bad-6-150-1
    :parameters ()
    :precondition (and (at bad-5-50-0))
    :effect (and (not (at bad-5-50-0)) (at bad-6-150-1) (increase (total-cost) 1)))

  (:action a-bad-6-150-2
    :parameters ()
    :precondition (and (at bad-5-50-0))
    :effect (and (not (at bad-5-50-0)) (at bad-6-150-2) (increase (total-cost) 1)))

  (:action a-bad-6-151-0
    :parameters ()
    :precondition (and (at bad-5-50-1))
    :effect (and (not (at bad-5-50-1)) (at bad-6-151-0) (increase (total-cost) 1)))

  (:action a-bad-6-151-1
    :parameters ()
    :precondition (and (at bad-5-50-1))
    :effect (and (not (at bad-5-50-1)) (at bad-6-151-1) (increase (total-cost) 1)))

  (:action a-bad-6-151-2
    :parameters ()
    :precondition (and (at bad-5-50-1))
    :effect (and (not (at bad-5-50-1)) (at bad-6-151-2) (increase (total-cost) 1)))

  (:action a-bad-6-152-0
    :parameters ()
    :precondition (and (at bad-5-50-2))
    :effect (and (not (at bad-5-50-2)) (at bad-6-152-0) (increase (total-cost) 1)))

  (:action a-bad-6-152-1
    :parameters ()
    :precondition (and (at bad-5-50-2))
    :effect (and (not (at bad-5-50-2)) (at bad-6-152-1) (increase (total-cost) 1)))

  (:action a-bad-6-152-2
    :parameters ()
    :precondition (and (at bad-5-50-2))
    :effect (and (not (at bad-5-50-2)) (at bad-6-152-2) (increase (total-cost) 1)))

  (:action a-bad-6-153-0
    :parameters ()
    :precondition (and (at bad-5-51-0))
    :effect (and (not (at bad-5-51-0)) (at bad-6-153-0) (increase (total-cost) 1)))

  (:action a-bad-6-153-1
    :parameters ()
    :precondition (and (at bad-5-51-0))
    :effect (and (not (at bad-5-51-0)) (at bad-6-153-1) (increase (total-cost) 1)))

  (:action a-bad-6-153-2
    :parameters ()
    :precondition (and (at bad-5-51-0))
    :effect (and (not (at bad-5-51-0)) (at bad-6-153-2) (increase (total-cost) 1)))

  (:action a-bad-6-154-0
    :parameters ()
    :precondition (and (at bad-5-51-1))
    :effect (and (not (at bad-5-51-1)) (at bad-6-154-0) (increase (total-cost) 1)))

  (:action a-bad-6-154-1
    :parameters ()
    :precondition (and (at bad-5-51-1))
    :effect (and (not (at bad-5-51-1)) (at bad-6-154-1) (increase (total-cost) 1)))

  (:action a-bad-6-154-2
    :parameters ()
    :precondition (and (at bad-5-51-1))
    :effect (and (not (at bad-5-51-1)) (at bad-6-154-2) (increase (total-cost) 1)))

  (:action a-bad-6-155-0
    :parameters ()
    :precondition (and (at bad-5-51-2))
    :effect (and (not (at bad-5-51-2)) (at bad-6-155-0) (increase (total-cost) 1)))

  (:action a-bad-6-155-1
    :parameters ()
    :precondition (and (at bad-5-51-2))
    :effect (and (not (at bad-5-51-2)) (at bad-6-155-1) (increase (total-cost) 1)))

  (:action a-bad-6-155-2
    :parameters ()
    :precondition (and (at bad-5-51-2))
    :effect (and (not (at bad-5-51-2)) (at bad-6-155-2) (increase (total-cost) 1)))

  (:action a-bad-6-156-0
    :parameters ()
    :precondition (and (at bad-5-52-0))
    :effect (and (not (at bad-5-52-0)) (at bad-6-156-0) (increase (total-cost) 1)))

  (:action a-bad-6-156-1
    :parameters ()
    :precondition (and (at bad-5-52-0))
    :effect (and (not (at bad-5-52-0)) (at bad-6-156-1) (increase (total-cost) 1)))

  (:action a-bad-6-156-2
    :parameters ()
    :precondition (and (at bad-5-52-0))
    :effect (and (not (at bad-5-52-0)) (at bad-6-156-2) (increase (total-cost) 1)))

  (:action a-bad-6-157-0
    :parameters ()
    :precondition (and (at bad-5-52-1))
    :effect (and (not (at bad-5-52-1)) (at bad-6-157-0) (increase (total-cost) 1)))

  (:action a-bad-6-157-1
    :parameters ()
    :precondition (and (at bad-5-52-1))
    :effect (and (not (at bad-5-52-1)) (at bad-6-157-1) (increase (total-cost) 1)))

  (:action a-bad-6-157-2
    :parameters ()
    :precondition (and (at bad-5-52-1))
    :effect (and (not (at bad-5-52-1)) (at bad-6-157-2) (increase (total-cost) 1)))

  (:action a-bad-6-158-0
    :parameters ()
    :precondition (and (at bad-5-52-2))
    :effect (and (not (at bad-5-52-2)) (at bad-6-158-0) (increase (total-cost) 1)))

  (:action a-bad-6-158-1
    :parameters ()
    :precondition (and (at bad-5-52-2))
    :effect (and (not (at bad-5-52-2)) (at bad-6-158-1) (increase (total-cost) 1)))

  (:action a-bad-6-158-2
    :parameters ()
    :precondition (and (at bad-5-52-2))
    :effect (and (not (at bad-5-52-2)) (at bad-6-158-2) (increase (total-cost) 1)))

  (:action a-bad-6-159-0
    :parameters ()
    :precondition (and (at bad-5-53-0))
    :effect (and (not (at bad-5-53-0)) (at bad-6-159-0) (increase (total-cost) 1)))

  (:action a-bad-6-159-1
    :parameters ()
    :precondition (and (at bad-5-53-0))
    :effect (and (not (at bad-5-53-0)) (at bad-6-159-1) (increase (total-cost) 1)))

  (:action a-bad-6-159-2
    :parameters ()
    :precondition (and (at bad-5-53-0))
    :effect (and (not (at bad-5-53-0)) (at bad-6-159-2) (increase (total-cost) 1)))

  (:action a-bad-6-160-0
    :parameters ()
    :precondition (and (at bad-5-53-1))
    :effect (and (not (at bad-5-53-1)) (at bad-6-160-0) (increase (total-cost) 1)))

  (:action a-bad-6-160-1
    :parameters ()
    :precondition (and (at bad-5-53-1))
    :effect (and (not (at bad-5-53-1)) (at bad-6-160-1) (increase (total-cost) 1)))

  (:action a-bad-6-160-2
    :parameters ()
    :precondition (and (at bad-5-53-1))
    :effect (and (not (at bad-5-53-1)) (at bad-6-160-2) (increase (total-cost) 1)))

  (:action a-bad-6-161-0
    :parameters ()
    :precondition (and (at bad-5-53-2))
    :effect (and (not (at bad-5-53-2)) (at bad-6-161-0) (increase (total-cost) 1)))

  (:action a-bad-6-161-1
    :parameters ()
    :precondition (and (at bad-5-53-2))
    :effect (and (not (at bad-5-53-2)) (at bad-6-161-1) (increase (total-cost) 1)))

  (:action a-bad-6-161-2
    :parameters ()
    :precondition (and (at bad-5-53-2))
    :effect (and (not (at bad-5-53-2)) (at bad-6-161-2) (increase (total-cost) 1)))

  (:action a-bad-6-162-0
    :parameters ()
    :precondition (and (at bad-5-54-0))
    :effect (and (not (at bad-5-54-0)) (at bad-6-162-0) (increase (total-cost) 1)))

  (:action a-bad-6-162-1
    :parameters ()
    :precondition (and (at bad-5-54-0))
    :effect (and (not (at bad-5-54-0)) (at bad-6-162-1) (increase (total-cost) 1)))

  (:action a-bad-6-162-2
    :parameters ()
    :precondition (and (at bad-5-54-0))
    :effect (and (not (at bad-5-54-0)) (at bad-6-162-2) (increase (total-cost) 1)))

  (:action a-bad-6-163-0
    :parameters ()
    :precondition (and (at bad-5-54-1))
    :effect (and (not (at bad-5-54-1)) (at bad-6-163-0) (increase (total-cost) 1)))

  (:action a-bad-6-163-1
    :parameters ()
    :precondition (and (at bad-5-54-1))
    :effect (and (not (at bad-5-54-1)) (at bad-6-163-1) (increase (total-cost) 1)))

  (:action a-bad-6-163-2
    :parameters ()
    :precondition (and (at bad-5-54-1))
    :effect (and (not (at bad-5-54-1)) (at bad-6-163-2) (increase (total-cost) 1)))

  (:action a-bad-6-164-0
    :parameters ()
    :precondition (and (at bad-5-54-2))
    :effect (and (not (at bad-5-54-2)) (at bad-6-164-0) (increase (total-cost) 1)))

  (:action a-bad-6-164-1
    :parameters ()
    :precondition (and (at bad-5-54-2))
    :effect (and (not (at bad-5-54-2)) (at bad-6-164-1) (increase (total-cost) 1)))

  (:action a-bad-6-164-2
    :parameters ()
    :precondition (and (at bad-5-54-2))
    :effect (and (not (at bad-5-54-2)) (at bad-6-164-2) (increase (total-cost) 1)))

  (:action a-bad-6-165-0
    :parameters ()
    :precondition (and (at bad-5-55-0))
    :effect (and (not (at bad-5-55-0)) (at bad-6-165-0) (increase (total-cost) 1)))

  (:action a-bad-6-165-1
    :parameters ()
    :precondition (and (at bad-5-55-0))
    :effect (and (not (at bad-5-55-0)) (at bad-6-165-1) (increase (total-cost) 1)))

  (:action a-bad-6-165-2
    :parameters ()
    :precondition (and (at bad-5-55-0))
    :effect (and (not (at bad-5-55-0)) (at bad-6-165-2) (increase (total-cost) 1)))

  (:action a-bad-6-166-0
    :parameters ()
    :precondition (and (at bad-5-55-1))
    :effect (and (not (at bad-5-55-1)) (at bad-6-166-0) (increase (total-cost) 1)))

  (:action a-bad-6-166-1
    :parameters ()
    :precondition (and (at bad-5-55-1))
    :effect (and (not (at bad-5-55-1)) (at bad-6-166-1) (increase (total-cost) 1)))

  (:action a-bad-6-166-2
    :parameters ()
    :precondition (and (at bad-5-55-1))
    :effect (and (not (at bad-5-55-1)) (at bad-6-166-2) (increase (total-cost) 1)))

  (:action a-bad-6-167-0
    :parameters ()
    :precondition (and (at bad-5-55-2))
    :effect (and (not (at bad-5-55-2)) (at bad-6-167-0) (increase (total-cost) 1)))

  (:action a-bad-6-167-1
    :parameters ()
    :precondition (and (at bad-5-55-2))
    :effect (and (not (at bad-5-55-2)) (at bad-6-167-1) (increase (total-cost) 1)))

  (:action a-bad-6-167-2
    :parameters ()
    :precondition (and (at bad-5-55-2))
    :effect (and (not (at bad-5-55-2)) (at bad-6-167-2) (increase (total-cost) 1)))

  (:action a-bad-6-168-0
    :parameters ()
    :precondition (and (at bad-5-56-0))
    :effect (and (not (at bad-5-56-0)) (at bad-6-168-0) (increase (total-cost) 1)))

  (:action a-bad-6-168-1
    :parameters ()
    :precondition (and (at bad-5-56-0))
    :effect (and (not (at bad-5-56-0)) (at bad-6-168-1) (increase (total-cost) 1)))

  (:action a-bad-6-168-2
    :parameters ()
    :precondition (and (at bad-5-56-0))
    :effect (and (not (at bad-5-56-0)) (at bad-6-168-2) (increase (total-cost) 1)))

  (:action a-bad-6-169-0
    :parameters ()
    :precondition (and (at bad-5-56-1))
    :effect (and (not (at bad-5-56-1)) (at bad-6-169-0) (increase (total-cost) 1)))

  (:action a-bad-6-169-1
    :parameters ()
    :precondition (and (at bad-5-56-1))
    :effect (and (not (at bad-5-56-1)) (at bad-6-169-1) (increase (total-cost) 1)))

  (:action a-bad-6-169-2
    :parameters ()
    :precondition (and (at bad-5-56-1))
    :effect (and (not (at bad-5-56-1)) (at bad-6-169-2) (increase (total-cost) 1)))

  (:action a-bad-6-170-0
    :parameters ()
    :precondition (and (at bad-5-56-2))
    :effect (and (not (at bad-5-56-2)) (at bad-6-170-0) (increase (total-cost) 1)))

  (:action a-bad-6-170-1
    :parameters ()
    :precondition (and (at bad-5-56-2))
    :effect (and (not (at bad-5-56-2)) (at bad-6-170-1) (increase (total-cost) 1)))

  (:action a-bad-6-170-2
    :parameters ()
    :precondition (and (at bad-5-56-2))
    :effect (and (not (at bad-5-56-2)) (at bad-6-170-2) (increase (total-cost) 1)))

  (:action a-bad-6-171-0
    :parameters ()
    :precondition (and (at bad-5-57-0))
    :effect (and (not (at bad-5-57-0)) (at bad-6-171-0) (increase (total-cost) 1)))

  (:action a-bad-6-171-1
    :parameters ()
    :precondition (and (at bad-5-57-0))
    :effect (and (not (at bad-5-57-0)) (at bad-6-171-1) (increase (total-cost) 1)))

  (:action a-bad-6-171-2
    :parameters ()
    :precondition (and (at bad-5-57-0))
    :effect (and (not (at bad-5-57-0)) (at bad-6-171-2) (increase (total-cost) 1)))

  (:action a-bad-6-172-0
    :parameters ()
    :precondition (and (at bad-5-57-1))
    :effect (and (not (at bad-5-57-1)) (at bad-6-172-0) (increase (total-cost) 1)))

  (:action a-bad-6-172-1
    :parameters ()
    :precondition (and (at bad-5-57-1))
    :effect (and (not (at bad-5-57-1)) (at bad-6-172-1) (increase (total-cost) 1)))

  (:action a-bad-6-172-2
    :parameters ()
    :precondition (and (at bad-5-57-1))
    :effect (and (not (at bad-5-57-1)) (at bad-6-172-2) (increase (total-cost) 1)))

  (:action a-bad-6-173-0
    :parameters ()
    :precondition (and (at bad-5-57-2))
    :effect (and (not (at bad-5-57-2)) (at bad-6-173-0) (increase (total-cost) 1)))

  (:action a-bad-6-173-1
    :parameters ()
    :precondition (and (at bad-5-57-2))
    :effect (and (not (at bad-5-57-2)) (at bad-6-173-1) (increase (total-cost) 1)))

  (:action a-bad-6-173-2
    :parameters ()
    :precondition (and (at bad-5-57-2))
    :effect (and (not (at bad-5-57-2)) (at bad-6-173-2) (increase (total-cost) 1)))

  (:action a-bad-6-174-0
    :parameters ()
    :precondition (and (at bad-5-58-0))
    :effect (and (not (at bad-5-58-0)) (at bad-6-174-0) (increase (total-cost) 1)))

  (:action a-bad-6-174-1
    :parameters ()
    :precondition (and (at bad-5-58-0))
    :effect (and (not (at bad-5-58-0)) (at bad-6-174-1) (increase (total-cost) 1)))

  (:action a-bad-6-174-2
    :parameters ()
    :precondition (and (at bad-5-58-0))
    :effect (and (not (at bad-5-58-0)) (at bad-6-174-2) (increase (total-cost) 1)))

  (:action a-bad-6-175-0
    :parameters ()
    :precondition (and (at bad-5-58-1))
    :effect (and (not (at bad-5-58-1)) (at bad-6-175-0) (increase (total-cost) 1)))

  (:action a-bad-6-175-1
    :parameters ()
    :precondition (and (at bad-5-58-1))
    :effect (and (not (at bad-5-58-1)) (at bad-6-175-1) (increase (total-cost) 1)))

  (:action a-bad-6-175-2
    :parameters ()
    :precondition (and (at bad-5-58-1))
    :effect (and (not (at bad-5-58-1)) (at bad-6-175-2) (increase (total-cost) 1)))

  (:action a-bad-6-176-0
    :parameters ()
    :precondition (and (at bad-5-58-2))
    :effect (and (not (at bad-5-58-2)) (at bad-6-176-0) (increase (total-cost) 1)))

  (:action a-bad-6-176-1
    :parameters ()
    :precondition (and (at bad-5-58-2))
    :effect (and (not (at bad-5-58-2)) (at bad-6-176-1) (increase (total-cost) 1)))

  (:action a-bad-6-176-2
    :parameters ()
    :precondition (and (at bad-5-58-2))
    :effect (and (not (at bad-5-58-2)) (at bad-6-176-2) (increase (total-cost) 1)))

  (:action a-bad-6-177-0
    :parameters ()
    :precondition (and (at bad-5-59-0))
    :effect (and (not (at bad-5-59-0)) (at bad-6-177-0) (increase (total-cost) 1)))

  (:action a-bad-6-177-1
    :parameters ()
    :precondition (and (at bad-5-59-0))
    :effect (and (not (at bad-5-59-0)) (at bad-6-177-1) (increase (total-cost) 1)))

  (:action a-bad-6-177-2
    :parameters ()
    :precondition (and (at bad-5-59-0))
    :effect (and (not (at bad-5-59-0)) (at bad-6-177-2) (increase (total-cost) 1)))

  (:action a-bad-6-178-0
    :parameters ()
    :precondition (and (at bad-5-59-1))
    :effect (and (not (at bad-5-59-1)) (at bad-6-178-0) (increase (total-cost) 1)))

  (:action a-bad-6-178-1
    :parameters ()
    :precondition (and (at bad-5-59-1))
    :effect (and (not (at bad-5-59-1)) (at bad-6-178-1) (increase (total-cost) 1)))

  (:action a-bad-6-178-2
    :parameters ()
    :precondition (and (at bad-5-59-1))
    :effect (and (not (at bad-5-59-1)) (at bad-6-178-2) (increase (total-cost) 1)))

  (:action a-bad-6-179-0
    :parameters ()
    :precondition (and (at bad-5-59-2))
    :effect (and (not (at bad-5-59-2)) (at bad-6-179-0) (increase (total-cost) 1)))

  (:action a-bad-6-179-1
    :parameters ()
    :precondition (and (at bad-5-59-2))
    :effect (and (not (at bad-5-59-2)) (at bad-6-179-1) (increase (total-cost) 1)))

  (:action a-bad-6-179-2
    :parameters ()
    :precondition (and (at bad-5-59-2))
    :effect (and (not (at bad-5-59-2)) (at bad-6-179-2) (increase (total-cost) 1)))

  (:action a-bad-6-180-0
    :parameters ()
    :precondition (and (at bad-5-60-0))
    :effect (and (not (at bad-5-60-0)) (at bad-6-180-0) (increase (total-cost) 1)))

  (:action a-bad-6-180-1
    :parameters ()
    :precondition (and (at bad-5-60-0))
    :effect (and (not (at bad-5-60-0)) (at bad-6-180-1) (increase (total-cost) 1)))

  (:action a-bad-6-180-2
    :parameters ()
    :precondition (and (at bad-5-60-0))
    :effect (and (not (at bad-5-60-0)) (at bad-6-180-2) (increase (total-cost) 1)))

  (:action a-bad-6-181-0
    :parameters ()
    :precondition (and (at bad-5-60-1))
    :effect (and (not (at bad-5-60-1)) (at bad-6-181-0) (increase (total-cost) 1)))

  (:action a-bad-6-181-1
    :parameters ()
    :precondition (and (at bad-5-60-1))
    :effect (and (not (at bad-5-60-1)) (at bad-6-181-1) (increase (total-cost) 1)))

  (:action a-bad-6-181-2
    :parameters ()
    :precondition (and (at bad-5-60-1))
    :effect (and (not (at bad-5-60-1)) (at bad-6-181-2) (increase (total-cost) 1)))

  (:action a-bad-6-182-0
    :parameters ()
    :precondition (and (at bad-5-60-2))
    :effect (and (not (at bad-5-60-2)) (at bad-6-182-0) (increase (total-cost) 1)))

  (:action a-bad-6-182-1
    :parameters ()
    :precondition (and (at bad-5-60-2))
    :effect (and (not (at bad-5-60-2)) (at bad-6-182-1) (increase (total-cost) 1)))

  (:action a-bad-6-182-2
    :parameters ()
    :precondition (and (at bad-5-60-2))
    :effect (and (not (at bad-5-60-2)) (at bad-6-182-2) (increase (total-cost) 1)))

  (:action a-bad-6-183-0
    :parameters ()
    :precondition (and (at bad-5-61-0))
    :effect (and (not (at bad-5-61-0)) (at bad-6-183-0) (increase (total-cost) 1)))

  (:action a-bad-6-183-1
    :parameters ()
    :precondition (and (at bad-5-61-0))
    :effect (and (not (at bad-5-61-0)) (at bad-6-183-1) (increase (total-cost) 1)))

  (:action a-bad-6-183-2
    :parameters ()
    :precondition (and (at bad-5-61-0))
    :effect (and (not (at bad-5-61-0)) (at bad-6-183-2) (increase (total-cost) 1)))

  (:action a-bad-6-184-0
    :parameters ()
    :precondition (and (at bad-5-61-1))
    :effect (and (not (at bad-5-61-1)) (at bad-6-184-0) (increase (total-cost) 1)))

  (:action a-bad-6-184-1
    :parameters ()
    :precondition (and (at bad-5-61-1))
    :effect (and (not (at bad-5-61-1)) (at bad-6-184-1) (increase (total-cost) 1)))

  (:action a-bad-6-184-2
    :parameters ()
    :precondition (and (at bad-5-61-1))
    :effect (and (not (at bad-5-61-1)) (at bad-6-184-2) (increase (total-cost) 1)))

  (:action a-bad-6-185-0
    :parameters ()
    :precondition (and (at bad-5-61-2))
    :effect (and (not (at bad-5-61-2)) (at bad-6-185-0) (increase (total-cost) 1)))

  (:action a-bad-6-185-1
    :parameters ()
    :precondition (and (at bad-5-61-2))
    :effect (and (not (at bad-5-61-2)) (at bad-6-185-1) (increase (total-cost) 1)))

  (:action a-bad-6-185-2
    :parameters ()
    :precondition (and (at bad-5-61-2))
    :effect (and (not (at bad-5-61-2)) (at bad-6-185-2) (increase (total-cost) 1)))

  (:action a-bad-6-186-0
    :parameters ()
    :precondition (and (at bad-5-62-0))
    :effect (and (not (at bad-5-62-0)) (at bad-6-186-0) (increase (total-cost) 1)))

  (:action a-bad-6-186-1
    :parameters ()
    :precondition (and (at bad-5-62-0))
    :effect (and (not (at bad-5-62-0)) (at bad-6-186-1) (increase (total-cost) 1)))

  (:action a-bad-6-186-2
    :parameters ()
    :precondition (and (at bad-5-62-0))
    :effect (and (not (at bad-5-62-0)) (at bad-6-186-2) (increase (total-cost) 1)))

  (:action a-bad-6-187-0
    :parameters ()
    :precondition (and (at bad-5-62-1))
    :effect (and (not (at bad-5-62-1)) (at bad-6-187-0) (increase (total-cost) 1)))

  (:action a-bad-6-187-1
    :parameters ()
    :precondition (and (at bad-5-62-1))
    :effect (and (not (at bad-5-62-1)) (at bad-6-187-1) (increase (total-cost) 1)))

  (:action a-bad-6-187-2
    :parameters ()
    :precondition (and (at bad-5-62-1))
    :effect (and (not (at bad-5-62-1)) (at bad-6-187-2) (increase (total-cost) 1)))

  (:action a-bad-6-188-0
    :parameters ()
    :precondition (and (at bad-5-62-2))
    :effect (and (not (at bad-5-62-2)) (at bad-6-188-0) (increase (total-cost) 1)))

  (:action a-bad-6-188-1
    :parameters ()
    :precondition (and (at bad-5-62-2))
    :effect (and (not (at bad-5-62-2)) (at bad-6-188-1) (increase (total-cost) 1)))

  (:action a-bad-6-188-2
    :parameters ()
    :precondition (and (at bad-5-62-2))
    :effect (and (not (at bad-5-62-2)) (at bad-6-188-2) (increase (total-cost) 1)))

  (:action a-bad-6-189-0
    :parameters ()
    :precondition (and (at bad-5-63-0))
    :effect (and (not (at bad-5-63-0)) (at bad-6-189-0) (increase (total-cost) 1)))

  (:action a-bad-6-189-1
    :parameters ()
    :precondition (and (at bad-5-63-0))
    :effect (and (not (at bad-5-63-0)) (at bad-6-189-1) (increase (total-cost) 1)))

  (:action a-bad-6-189-2
    :parameters ()
    :precondition (and (at bad-5-63-0))
    :effect (and (not (at bad-5-63-0)) (at bad-6-189-2) (increase (total-cost) 1)))

  (:action a-bad-6-190-0
    :parameters ()
    :precondition (and (at bad-5-63-1))
    :effect (and (not (at bad-5-63-1)) (at bad-6-190-0) (increase (total-cost) 1)))

  (:action a-bad-6-190-1
    :parameters ()
    :precondition (and (at bad-5-63-1))
    :effect (and (not (at bad-5-63-1)) (at bad-6-190-1) (increase (total-cost) 1)))

  (:action a-bad-6-190-2
    :parameters ()
    :precondition (and (at bad-5-63-1))
    :effect (and (not (at bad-5-63-1)) (at bad-6-190-2) (increase (total-cost) 1)))

  (:action a-bad-6-191-0
    :parameters ()
    :precondition (and (at bad-5-63-2))
    :effect (and (not (at bad-5-63-2)) (at bad-6-191-0) (increase (total-cost) 1)))

  (:action a-bad-6-191-1
    :parameters ()
    :precondition (and (at bad-5-63-2))
    :effect (and (not (at bad-5-63-2)) (at bad-6-191-1) (increase (total-cost) 1)))

  (:action a-bad-6-191-2
    :parameters ()
    :precondition (and (at bad-5-63-2))
    :effect (and (not (at bad-5-63-2)) (at bad-6-191-2) (increase (total-cost) 1)))

  (:action a-bad-6-192-0
    :parameters ()
    :precondition (and (at bad-5-64-0))
    :effect (and (not (at bad-5-64-0)) (at bad-6-192-0) (increase (total-cost) 1)))

  (:action a-bad-6-192-1
    :parameters ()
    :precondition (and (at bad-5-64-0))
    :effect (and (not (at bad-5-64-0)) (at bad-6-192-1) (increase (total-cost) 1)))

  (:action a-bad-6-192-2
    :parameters ()
    :precondition (and (at bad-5-64-0))
    :effect (and (not (at bad-5-64-0)) (at bad-6-192-2) (increase (total-cost) 1)))

  (:action a-bad-6-193-0
    :parameters ()
    :precondition (and (at bad-5-64-1))
    :effect (and (not (at bad-5-64-1)) (at bad-6-193-0) (increase (total-cost) 1)))

  (:action a-bad-6-193-1
    :parameters ()
    :precondition (and (at bad-5-64-1))
    :effect (and (not (at bad-5-64-1)) (at bad-6-193-1) (increase (total-cost) 1)))

  (:action a-bad-6-193-2
    :parameters ()
    :precondition (and (at bad-5-64-1))
    :effect (and (not (at bad-5-64-1)) (at bad-6-193-2) (increase (total-cost) 1)))

  (:action a-bad-6-194-0
    :parameters ()
    :precondition (and (at bad-5-64-2))
    :effect (and (not (at bad-5-64-2)) (at bad-6-194-0) (increase (total-cost) 1)))

  (:action a-bad-6-194-1
    :parameters ()
    :precondition (and (at bad-5-64-2))
    :effect (and (not (at bad-5-64-2)) (at bad-6-194-1) (increase (total-cost) 1)))

  (:action a-bad-6-194-2
    :parameters ()
    :precondition (and (at bad-5-64-2))
    :effect (and (not (at bad-5-64-2)) (at bad-6-194-2) (increase (total-cost) 1)))

  (:action a-bad-6-195-0
    :parameters ()
    :precondition (and (at bad-5-65-0))
    :effect (and (not (at bad-5-65-0)) (at bad-6-195-0) (increase (total-cost) 1)))

  (:action a-bad-6-195-1
    :parameters ()
    :precondition (and (at bad-5-65-0))
    :effect (and (not (at bad-5-65-0)) (at bad-6-195-1) (increase (total-cost) 1)))

  (:action a-bad-6-195-2
    :parameters ()
    :precondition (and (at bad-5-65-0))
    :effect (and (not (at bad-5-65-0)) (at bad-6-195-2) (increase (total-cost) 1)))

  (:action a-bad-6-196-0
    :parameters ()
    :precondition (and (at bad-5-65-1))
    :effect (and (not (at bad-5-65-1)) (at bad-6-196-0) (increase (total-cost) 1)))

  (:action a-bad-6-196-1
    :parameters ()
    :precondition (and (at bad-5-65-1))
    :effect (and (not (at bad-5-65-1)) (at bad-6-196-1) (increase (total-cost) 1)))

  (:action a-bad-6-196-2
    :parameters ()
    :precondition (and (at bad-5-65-1))
    :effect (and (not (at bad-5-65-1)) (at bad-6-196-2) (increase (total-cost) 1)))

  (:action a-bad-6-197-0
    :parameters ()
    :precondition (and (at bad-5-65-2))
    :effect (and (not (at bad-5-65-2)) (at bad-6-197-0) (increase (total-cost) 1)))

  (:action a-bad-6-197-1
    :parameters ()
    :precondition (and (at bad-5-65-2))
    :effect (and (not (at bad-5-65-2)) (at bad-6-197-1) (increase (total-cost) 1)))

  (:action a-bad-6-197-2
    :parameters ()
    :precondition (and (at bad-5-65-2))
    :effect (and (not (at bad-5-65-2)) (at bad-6-197-2) (increase (total-cost) 1)))

  (:action a-bad-6-198-0
    :parameters ()
    :precondition (and (at bad-5-66-0))
    :effect (and (not (at bad-5-66-0)) (at bad-6-198-0) (increase (total-cost) 1)))

  (:action a-bad-6-198-1
    :parameters ()
    :precondition (and (at bad-5-66-0))
    :effect (and (not (at bad-5-66-0)) (at bad-6-198-1) (increase (total-cost) 1)))

  (:action a-bad-6-198-2
    :parameters ()
    :precondition (and (at bad-5-66-0))
    :effect (and (not (at bad-5-66-0)) (at bad-6-198-2) (increase (total-cost) 1)))

  (:action a-bad-6-199-0
    :parameters ()
    :precondition (and (at bad-5-66-1))
    :effect (and (not (at bad-5-66-1)) (at bad-6-199-0) (increase (total-cost) 1)))

  (:action a-bad-6-199-1
    :parameters ()
    :precondition (and (at bad-5-66-1))
    :effect (and (not (at bad-5-66-1)) (at bad-6-199-1) (increase (total-cost) 1)))

  (:action a-bad-6-199-2
    :parameters ()
    :precondition (and (at bad-5-66-1))
    :effect (and (not (at bad-5-66-1)) (at bad-6-199-2) (increase (total-cost) 1)))

  (:action a-bad-6-200-0
    :parameters ()
    :precondition (and (at bad-5-66-2))
    :effect (and (not (at bad-5-66-2)) (at bad-6-200-0) (increase (total-cost) 1)))

  (:action a-bad-6-200-1
    :parameters ()
    :precondition (and (at bad-5-66-2))
    :effect (and (not (at bad-5-66-2)) (at bad-6-200-1) (increase (total-cost) 1)))

  (:action a-bad-6-200-2
    :parameters ()
    :precondition (and (at bad-5-66-2))
    :effect (and (not (at bad-5-66-2)) (at bad-6-200-2) (increase (total-cost) 1)))

  (:action a-bad-6-201-0
    :parameters ()
    :precondition (and (at bad-5-67-0))
    :effect (and (not (at bad-5-67-0)) (at bad-6-201-0) (increase (total-cost) 1)))

  (:action a-bad-6-201-1
    :parameters ()
    :precondition (and (at bad-5-67-0))
    :effect (and (not (at bad-5-67-0)) (at bad-6-201-1) (increase (total-cost) 1)))

  (:action a-bad-6-201-2
    :parameters ()
    :precondition (and (at bad-5-67-0))
    :effect (and (not (at bad-5-67-0)) (at bad-6-201-2) (increase (total-cost) 1)))

  (:action a-bad-6-202-0
    :parameters ()
    :precondition (and (at bad-5-67-1))
    :effect (and (not (at bad-5-67-1)) (at bad-6-202-0) (increase (total-cost) 1)))

  (:action a-bad-6-202-1
    :parameters ()
    :precondition (and (at bad-5-67-1))
    :effect (and (not (at bad-5-67-1)) (at bad-6-202-1) (increase (total-cost) 1)))

  (:action a-bad-6-202-2
    :parameters ()
    :precondition (and (at bad-5-67-1))
    :effect (and (not (at bad-5-67-1)) (at bad-6-202-2) (increase (total-cost) 1)))

  (:action a-bad-6-203-0
    :parameters ()
    :precondition (and (at bad-5-67-2))
    :effect (and (not (at bad-5-67-2)) (at bad-6-203-0) (increase (total-cost) 1)))

  (:action a-bad-6-203-1
    :parameters ()
    :precondition (and (at bad-5-67-2))
    :effect (and (not (at bad-5-67-2)) (at bad-6-203-1) (increase (total-cost) 1)))

  (:action a-bad-6-203-2
    :parameters ()
    :precondition (and (at bad-5-67-2))
    :effect (and (not (at bad-5-67-2)) (at bad-6-203-2) (increase (total-cost) 1)))

  (:action a-bad-6-204-0
    :parameters ()
    :precondition (and (at bad-5-68-0))
    :effect (and (not (at bad-5-68-0)) (at bad-6-204-0) (increase (total-cost) 1)))

  (:action a-bad-6-204-1
    :parameters ()
    :precondition (and (at bad-5-68-0))
    :effect (and (not (at bad-5-68-0)) (at bad-6-204-1) (increase (total-cost) 1)))

  (:action a-bad-6-204-2
    :parameters ()
    :precondition (and (at bad-5-68-0))
    :effect (and (not (at bad-5-68-0)) (at bad-6-204-2) (increase (total-cost) 1)))

  (:action a-bad-6-205-0
    :parameters ()
    :precondition (and (at bad-5-68-1))
    :effect (and (not (at bad-5-68-1)) (at bad-6-205-0) (increase (total-cost) 1)))

  (:action a-bad-6-205-1
    :parameters ()
    :precondition (and (at bad-5-68-1))
    :effect (and (not (at bad-5-68-1)) (at bad-6-205-1) (increase (total-cost) 1)))

  (:action a-bad-6-205-2
    :parameters ()
    :precondition (and (at bad-5-68-1))
    :effect (and (not (at bad-5-68-1)) (at bad-6-205-2) (increase (total-cost) 1)))

  (:action a-bad-6-206-0
    :parameters ()
    :precondition (and (at bad-5-68-2))
    :effect (and (not (at bad-5-68-2)) (at bad-6-206-0) (increase (total-cost) 1)))

  (:action a-bad-6-206-1
    :parameters ()
    :precondition (and (at bad-5-68-2))
    :effect (and (not (at bad-5-68-2)) (at bad-6-206-1) (increase (total-cost) 1)))

  (:action a-bad-6-206-2
    :parameters ()
    :precondition (and (at bad-5-68-2))
    :effect (and (not (at bad-5-68-2)) (at bad-6-206-2) (increase (total-cost) 1)))

  (:action a-bad-6-207-0
    :parameters ()
    :precondition (and (at bad-5-69-0))
    :effect (and (not (at bad-5-69-0)) (at bad-6-207-0) (increase (total-cost) 1)))

  (:action a-bad-6-207-1
    :parameters ()
    :precondition (and (at bad-5-69-0))
    :effect (and (not (at bad-5-69-0)) (at bad-6-207-1) (increase (total-cost) 1)))

  (:action a-bad-6-207-2
    :parameters ()
    :precondition (and (at bad-5-69-0))
    :effect (and (not (at bad-5-69-0)) (at bad-6-207-2) (increase (total-cost) 1)))

  (:action a-bad-6-208-0
    :parameters ()
    :precondition (and (at bad-5-69-1))
    :effect (and (not (at bad-5-69-1)) (at bad-6-208-0) (increase (total-cost) 1)))

  (:action a-bad-6-208-1
    :parameters ()
    :precondition (and (at bad-5-69-1))
    :effect (and (not (at bad-5-69-1)) (at bad-6-208-1) (increase (total-cost) 1)))

  (:action a-bad-6-208-2
    :parameters ()
    :precondition (and (at bad-5-69-1))
    :effect (and (not (at bad-5-69-1)) (at bad-6-208-2) (increase (total-cost) 1)))

  (:action a-bad-6-209-0
    :parameters ()
    :precondition (and (at bad-5-69-2))
    :effect (and (not (at bad-5-69-2)) (at bad-6-209-0) (increase (total-cost) 1)))

  (:action a-bad-6-209-1
    :parameters ()
    :precondition (and (at bad-5-69-2))
    :effect (and (not (at bad-5-69-2)) (at bad-6-209-1) (increase (total-cost) 1)))

  (:action a-bad-6-209-2
    :parameters ()
    :precondition (and (at bad-5-69-2))
    :effect (and (not (at bad-5-69-2)) (at bad-6-209-2) (increase (total-cost) 1)))

  (:action a-bad-6-210-0
    :parameters ()
    :precondition (and (at bad-5-70-0))
    :effect (and (not (at bad-5-70-0)) (at bad-6-210-0) (increase (total-cost) 1)))

  (:action a-bad-6-210-1
    :parameters ()
    :precondition (and (at bad-5-70-0))
    :effect (and (not (at bad-5-70-0)) (at bad-6-210-1) (increase (total-cost) 1)))

  (:action a-bad-6-210-2
    :parameters ()
    :precondition (and (at bad-5-70-0))
    :effect (and (not (at bad-5-70-0)) (at bad-6-210-2) (increase (total-cost) 1)))

  (:action a-bad-6-211-0
    :parameters ()
    :precondition (and (at bad-5-70-1))
    :effect (and (not (at bad-5-70-1)) (at bad-6-211-0) (increase (total-cost) 1)))

  (:action a-bad-6-211-1
    :parameters ()
    :precondition (and (at bad-5-70-1))
    :effect (and (not (at bad-5-70-1)) (at bad-6-211-1) (increase (total-cost) 1)))

  (:action a-bad-6-211-2
    :parameters ()
    :precondition (and (at bad-5-70-1))
    :effect (and (not (at bad-5-70-1)) (at bad-6-211-2) (increase (total-cost) 1)))

  (:action a-bad-6-212-0
    :parameters ()
    :precondition (and (at bad-5-70-2))
    :effect (and (not (at bad-5-70-2)) (at bad-6-212-0) (increase (total-cost) 1)))

  (:action a-bad-6-212-1
    :parameters ()
    :precondition (and (at bad-5-70-2))
    :effect (and (not (at bad-5-70-2)) (at bad-6-212-1) (increase (total-cost) 1)))

  (:action a-bad-6-212-2
    :parameters ()
    :precondition (and (at bad-5-70-2))
    :effect (and (not (at bad-5-70-2)) (at bad-6-212-2) (increase (total-cost) 1)))

  (:action a-bad-6-213-0
    :parameters ()
    :precondition (and (at bad-5-71-0))
    :effect (and (not (at bad-5-71-0)) (at bad-6-213-0) (increase (total-cost) 1)))

  (:action a-bad-6-213-1
    :parameters ()
    :precondition (and (at bad-5-71-0))
    :effect (and (not (at bad-5-71-0)) (at bad-6-213-1) (increase (total-cost) 1)))

  (:action a-bad-6-213-2
    :parameters ()
    :precondition (and (at bad-5-71-0))
    :effect (and (not (at bad-5-71-0)) (at bad-6-213-2) (increase (total-cost) 1)))

  (:action a-bad-6-214-0
    :parameters ()
    :precondition (and (at bad-5-71-1))
    :effect (and (not (at bad-5-71-1)) (at bad-6-214-0) (increase (total-cost) 1)))

  (:action a-bad-6-214-1
    :parameters ()
    :precondition (and (at bad-5-71-1))
    :effect (and (not (at bad-5-71-1)) (at bad-6-214-1) (increase (total-cost) 1)))

  (:action a-bad-6-214-2
    :parameters ()
    :precondition (and (at bad-5-71-1))
    :effect (and (not (at bad-5-71-1)) (at bad-6-214-2) (increase (total-cost) 1)))

  (:action a-bad-6-215-0
    :parameters ()
    :precondition (and (at bad-5-71-2))
    :effect (and (not (at bad-5-71-2)) (at bad-6-215-0) (increase (total-cost) 1)))

  (:action a-bad-6-215-1
    :parameters ()
    :precondition (and (at bad-5-71-2))
    :effect (and (not (at bad-5-71-2)) (at bad-6-215-1) (increase (total-cost) 1)))

  (:action a-bad-6-215-2
    :parameters ()
    :precondition (and (at bad-5-71-2))
    :effect (and (not (at bad-5-71-2)) (at bad-6-215-2) (increase (total-cost) 1)))

  (:action a-bad-6-216-0
    :parameters ()
    :precondition (and (at bad-5-72-0))
    :effect (and (not (at bad-5-72-0)) (at bad-6-216-0) (increase (total-cost) 1)))

  (:action a-bad-6-216-1
    :parameters ()
    :precondition (and (at bad-5-72-0))
    :effect (and (not (at bad-5-72-0)) (at bad-6-216-1) (increase (total-cost) 1)))

  (:action a-bad-6-216-2
    :parameters ()
    :precondition (and (at bad-5-72-0))
    :effect (and (not (at bad-5-72-0)) (at bad-6-216-2) (increase (total-cost) 1)))

  (:action a-bad-6-217-0
    :parameters ()
    :precondition (and (at bad-5-72-1))
    :effect (and (not (at bad-5-72-1)) (at bad-6-217-0) (increase (total-cost) 1)))

  (:action a-bad-6-217-1
    :parameters ()
    :precondition (and (at bad-5-72-1))
    :effect (and (not (at bad-5-72-1)) (at bad-6-217-1) (increase (total-cost) 1)))

  (:action a-bad-6-217-2
    :parameters ()
    :precondition (and (at bad-5-72-1))
    :effect (and (not (at bad-5-72-1)) (at bad-6-217-2) (increase (total-cost) 1)))

  (:action a-bad-6-218-0
    :parameters ()
    :precondition (and (at bad-5-72-2))
    :effect (and (not (at bad-5-72-2)) (at bad-6-218-0) (increase (total-cost) 1)))

  (:action a-bad-6-218-1
    :parameters ()
    :precondition (and (at bad-5-72-2))
    :effect (and (not (at bad-5-72-2)) (at bad-6-218-1) (increase (total-cost) 1)))

  (:action a-bad-6-218-2
    :parameters ()
    :precondition (and (at bad-5-72-2))
    :effect (and (not (at bad-5-72-2)) (at bad-6-218-2) (increase (total-cost) 1)))

  (:action a-bad-6-219-0
    :parameters ()
    :precondition (and (at bad-5-73-0))
    :effect (and (not (at bad-5-73-0)) (at bad-6-219-0) (increase (total-cost) 1)))

  (:action a-bad-6-219-1
    :parameters ()
    :precondition (and (at bad-5-73-0))
    :effect (and (not (at bad-5-73-0)) (at bad-6-219-1) (increase (total-cost) 1)))

  (:action a-bad-6-219-2
    :parameters ()
    :precondition (and (at bad-5-73-0))
    :effect (and (not (at bad-5-73-0)) (at bad-6-219-2) (increase (total-cost) 1)))

  (:action a-bad-6-220-0
    :parameters ()
    :precondition (and (at bad-5-73-1))
    :effect (and (not (at bad-5-73-1)) (at bad-6-220-0) (increase (total-cost) 1)))

  (:action a-bad-6-220-1
    :parameters ()
    :precondition (and (at bad-5-73-1))
    :effect (and (not (at bad-5-73-1)) (at bad-6-220-1) (increase (total-cost) 1)))

  (:action a-bad-6-220-2
    :parameters ()
    :precondition (and (at bad-5-73-1))
    :effect (and (not (at bad-5-73-1)) (at bad-6-220-2) (increase (total-cost) 1)))

  (:action a-bad-6-221-0
    :parameters ()
    :precondition (and (at bad-5-73-2))
    :effect (and (not (at bad-5-73-2)) (at bad-6-221-0) (increase (total-cost) 1)))

  (:action a-bad-6-221-1
    :parameters ()
    :precondition (and (at bad-5-73-2))
    :effect (and (not (at bad-5-73-2)) (at bad-6-221-1) (increase (total-cost) 1)))

  (:action a-bad-6-221-2
    :parameters ()
    :precondition (and (at bad-5-73-2))
    :effect (and (not (at bad-5-73-2)) (at bad-6-221-2) (increase (total-cost) 1)))

  (:action a-bad-6-222-0
    :parameters ()
    :precondition (and (at bad-5-74-0))
    :effect (and (not (at bad-5-74-0)) (at bad-6-222-0) (increase (total-cost) 1)))

  (:action a-bad-6-222-1
    :parameters ()
    :precondition (and (at bad-5-74-0))
    :effect (and (not (at bad-5-74-0)) (at bad-6-222-1) (increase (total-cost) 1)))

  (:action a-bad-6-222-2
    :parameters ()
    :precondition (and (at bad-5-74-0))
    :effect (and (not (at bad-5-74-0)) (at bad-6-222-2) (increase (total-cost) 1)))

  (:action a-bad-6-223-0
    :parameters ()
    :precondition (and (at bad-5-74-1))
    :effect (and (not (at bad-5-74-1)) (at bad-6-223-0) (increase (total-cost) 1)))

  (:action a-bad-6-223-1
    :parameters ()
    :precondition (and (at bad-5-74-1))
    :effect (and (not (at bad-5-74-1)) (at bad-6-223-1) (increase (total-cost) 1)))

  (:action a-bad-6-223-2
    :parameters ()
    :precondition (and (at bad-5-74-1))
    :effect (and (not (at bad-5-74-1)) (at bad-6-223-2) (increase (total-cost) 1)))

  (:action a-bad-6-224-0
    :parameters ()
    :precondition (and (at bad-5-74-2))
    :effect (and (not (at bad-5-74-2)) (at bad-6-224-0) (increase (total-cost) 1)))

  (:action a-bad-6-224-1
    :parameters ()
    :precondition (and (at bad-5-74-2))
    :effect (and (not (at bad-5-74-2)) (at bad-6-224-1) (increase (total-cost) 1)))

  (:action a-bad-6-224-2
    :parameters ()
    :precondition (and (at bad-5-74-2))
    :effect (and (not (at bad-5-74-2)) (at bad-6-224-2) (increase (total-cost) 1)))

  (:action a-bad-6-225-0
    :parameters ()
    :precondition (and (at bad-5-75-0))
    :effect (and (not (at bad-5-75-0)) (at bad-6-225-0) (increase (total-cost) 1)))

  (:action a-bad-6-225-1
    :parameters ()
    :precondition (and (at bad-5-75-0))
    :effect (and (not (at bad-5-75-0)) (at bad-6-225-1) (increase (total-cost) 1)))

  (:action a-bad-6-225-2
    :parameters ()
    :precondition (and (at bad-5-75-0))
    :effect (and (not (at bad-5-75-0)) (at bad-6-225-2) (increase (total-cost) 1)))

  (:action a-bad-6-226-0
    :parameters ()
    :precondition (and (at bad-5-75-1))
    :effect (and (not (at bad-5-75-1)) (at bad-6-226-0) (increase (total-cost) 1)))

  (:action a-bad-6-226-1
    :parameters ()
    :precondition (and (at bad-5-75-1))
    :effect (and (not (at bad-5-75-1)) (at bad-6-226-1) (increase (total-cost) 1)))

  (:action a-bad-6-226-2
    :parameters ()
    :precondition (and (at bad-5-75-1))
    :effect (and (not (at bad-5-75-1)) (at bad-6-226-2) (increase (total-cost) 1)))

  (:action a-bad-6-227-0
    :parameters ()
    :precondition (and (at bad-5-75-2))
    :effect (and (not (at bad-5-75-2)) (at bad-6-227-0) (increase (total-cost) 1)))

  (:action a-bad-6-227-1
    :parameters ()
    :precondition (and (at bad-5-75-2))
    :effect (and (not (at bad-5-75-2)) (at bad-6-227-1) (increase (total-cost) 1)))

  (:action a-bad-6-227-2
    :parameters ()
    :precondition (and (at bad-5-75-2))
    :effect (and (not (at bad-5-75-2)) (at bad-6-227-2) (increase (total-cost) 1)))

  (:action a-bad-6-228-0
    :parameters ()
    :precondition (and (at bad-5-76-0))
    :effect (and (not (at bad-5-76-0)) (at bad-6-228-0) (increase (total-cost) 1)))

  (:action a-bad-6-228-1
    :parameters ()
    :precondition (and (at bad-5-76-0))
    :effect (and (not (at bad-5-76-0)) (at bad-6-228-1) (increase (total-cost) 1)))

  (:action a-bad-6-228-2
    :parameters ()
    :precondition (and (at bad-5-76-0))
    :effect (and (not (at bad-5-76-0)) (at bad-6-228-2) (increase (total-cost) 1)))

  (:action a-bad-6-229-0
    :parameters ()
    :precondition (and (at bad-5-76-1))
    :effect (and (not (at bad-5-76-1)) (at bad-6-229-0) (increase (total-cost) 1)))

  (:action a-bad-6-229-1
    :parameters ()
    :precondition (and (at bad-5-76-1))
    :effect (and (not (at bad-5-76-1)) (at bad-6-229-1) (increase (total-cost) 1)))

  (:action a-bad-6-229-2
    :parameters ()
    :precondition (and (at bad-5-76-1))
    :effect (and (not (at bad-5-76-1)) (at bad-6-229-2) (increase (total-cost) 1)))

  (:action a-bad-6-230-0
    :parameters ()
    :precondition (and (at bad-5-76-2))
    :effect (and (not (at bad-5-76-2)) (at bad-6-230-0) (increase (total-cost) 1)))

  (:action a-bad-6-230-1
    :parameters ()
    :precondition (and (at bad-5-76-2))
    :effect (and (not (at bad-5-76-2)) (at bad-6-230-1) (increase (total-cost) 1)))

  (:action a-bad-6-230-2
    :parameters ()
    :precondition (and (at bad-5-76-2))
    :effect (and (not (at bad-5-76-2)) (at bad-6-230-2) (increase (total-cost) 1)))

  (:action a-bad-6-231-0
    :parameters ()
    :precondition (and (at bad-5-77-0))
    :effect (and (not (at bad-5-77-0)) (at bad-6-231-0) (increase (total-cost) 1)))

  (:action a-bad-6-231-1
    :parameters ()
    :precondition (and (at bad-5-77-0))
    :effect (and (not (at bad-5-77-0)) (at bad-6-231-1) (increase (total-cost) 1)))

  (:action a-bad-6-231-2
    :parameters ()
    :precondition (and (at bad-5-77-0))
    :effect (and (not (at bad-5-77-0)) (at bad-6-231-2) (increase (total-cost) 1)))

  (:action a-bad-6-232-0
    :parameters ()
    :precondition (and (at bad-5-77-1))
    :effect (and (not (at bad-5-77-1)) (at bad-6-232-0) (increase (total-cost) 1)))

  (:action a-bad-6-232-1
    :parameters ()
    :precondition (and (at bad-5-77-1))
    :effect (and (not (at bad-5-77-1)) (at bad-6-232-1) (increase (total-cost) 1)))

  (:action a-bad-6-232-2
    :parameters ()
    :precondition (and (at bad-5-77-1))
    :effect (and (not (at bad-5-77-1)) (at bad-6-232-2) (increase (total-cost) 1)))

  (:action a-bad-6-233-0
    :parameters ()
    :precondition (and (at bad-5-77-2))
    :effect (and (not (at bad-5-77-2)) (at bad-6-233-0) (increase (total-cost) 1)))

  (:action a-bad-6-233-1
    :parameters ()
    :precondition (and (at bad-5-77-2))
    :effect (and (not (at bad-5-77-2)) (at bad-6-233-1) (increase (total-cost) 1)))

  (:action a-bad-6-233-2
    :parameters ()
    :precondition (and (at bad-5-77-2))
    :effect (and (not (at bad-5-77-2)) (at bad-6-233-2) (increase (total-cost) 1)))

  (:action a-bad-6-234-0
    :parameters ()
    :precondition (and (at bad-5-78-0))
    :effect (and (not (at bad-5-78-0)) (at bad-6-234-0) (increase (total-cost) 1)))

  (:action a-bad-6-234-1
    :parameters ()
    :precondition (and (at bad-5-78-0))
    :effect (and (not (at bad-5-78-0)) (at bad-6-234-1) (increase (total-cost) 1)))

  (:action a-bad-6-234-2
    :parameters ()
    :precondition (and (at bad-5-78-0))
    :effect (and (not (at bad-5-78-0)) (at bad-6-234-2) (increase (total-cost) 1)))

  (:action a-bad-6-235-0
    :parameters ()
    :precondition (and (at bad-5-78-1))
    :effect (and (not (at bad-5-78-1)) (at bad-6-235-0) (increase (total-cost) 1)))

  (:action a-bad-6-235-1
    :parameters ()
    :precondition (and (at bad-5-78-1))
    :effect (and (not (at bad-5-78-1)) (at bad-6-235-1) (increase (total-cost) 1)))

  (:action a-bad-6-235-2
    :parameters ()
    :precondition (and (at bad-5-78-1))
    :effect (and (not (at bad-5-78-1)) (at bad-6-235-2) (increase (total-cost) 1)))

  (:action a-bad-6-236-0
    :parameters ()
    :precondition (and (at bad-5-78-2))
    :effect (and (not (at bad-5-78-2)) (at bad-6-236-0) (increase (total-cost) 1)))

  (:action a-bad-6-236-1
    :parameters ()
    :precondition (and (at bad-5-78-2))
    :effect (and (not (at bad-5-78-2)) (at bad-6-236-1) (increase (total-cost) 1)))

  (:action a-bad-6-236-2
    :parameters ()
    :precondition (and (at bad-5-78-2))
    :effect (and (not (at bad-5-78-2)) (at bad-6-236-2) (increase (total-cost) 1)))

  (:action a-bad-6-237-0
    :parameters ()
    :precondition (and (at bad-5-79-0))
    :effect (and (not (at bad-5-79-0)) (at bad-6-237-0) (increase (total-cost) 1)))

  (:action a-bad-6-237-1
    :parameters ()
    :precondition (and (at bad-5-79-0))
    :effect (and (not (at bad-5-79-0)) (at bad-6-237-1) (increase (total-cost) 1)))

  (:action a-bad-6-237-2
    :parameters ()
    :precondition (and (at bad-5-79-0))
    :effect (and (not (at bad-5-79-0)) (at bad-6-237-2) (increase (total-cost) 1)))

  (:action a-bad-6-238-0
    :parameters ()
    :precondition (and (at bad-5-79-1))
    :effect (and (not (at bad-5-79-1)) (at bad-6-238-0) (increase (total-cost) 1)))

  (:action a-bad-6-238-1
    :parameters ()
    :precondition (and (at bad-5-79-1))
    :effect (and (not (at bad-5-79-1)) (at bad-6-238-1) (increase (total-cost) 1)))

  (:action a-bad-6-238-2
    :parameters ()
    :precondition (and (at bad-5-79-1))
    :effect (and (not (at bad-5-79-1)) (at bad-6-238-2) (increase (total-cost) 1)))

  (:action a-bad-6-239-0
    :parameters ()
    :precondition (and (at bad-5-79-2))
    :effect (and (not (at bad-5-79-2)) (at bad-6-239-0) (increase (total-cost) 1)))

  (:action a-bad-6-239-1
    :parameters ()
    :precondition (and (at bad-5-79-2))
    :effect (and (not (at bad-5-79-2)) (at bad-6-239-1) (increase (total-cost) 1)))

  (:action a-bad-6-239-2
    :parameters ()
    :precondition (and (at bad-5-79-2))
    :effect (and (not (at bad-5-79-2)) (at bad-6-239-2) (increase (total-cost) 1)))

  (:action a-bad-6-240-0
    :parameters ()
    :precondition (and (at bad-5-80-0))
    :effect (and (not (at bad-5-80-0)) (at bad-6-240-0) (increase (total-cost) 1)))

  (:action a-bad-6-240-1
    :parameters ()
    :precondition (and (at bad-5-80-0))
    :effect (and (not (at bad-5-80-0)) (at bad-6-240-1) (increase (total-cost) 1)))

  (:action a-bad-6-240-2
    :parameters ()
    :precondition (and (at bad-5-80-0))
    :effect (and (not (at bad-5-80-0)) (at bad-6-240-2) (increase (total-cost) 1)))

  (:action a-bad-6-241-0
    :parameters ()
    :precondition (and (at bad-5-80-1))
    :effect (and (not (at bad-5-80-1)) (at bad-6-241-0) (increase (total-cost) 1)))

  (:action a-bad-6-241-1
    :parameters ()
    :precondition (and (at bad-5-80-1))
    :effect (and (not (at bad-5-80-1)) (at bad-6-241-1) (increase (total-cost) 1)))

  (:action a-bad-6-241-2
    :parameters ()
    :precondition (and (at bad-5-80-1))
    :effect (and (not (at bad-5-80-1)) (at bad-6-241-2) (increase (total-cost) 1)))

  (:action a-bad-6-242-0
    :parameters ()
    :precondition (and (at bad-5-80-2))
    :effect (and (not (at bad-5-80-2)) (at bad-6-242-0) (increase (total-cost) 1)))

  (:action a-bad-6-242-1
    :parameters ()
    :precondition (and (at bad-5-80-2))
    :effect (and (not (at bad-5-80-2)) (at bad-6-242-1) (increase (total-cost) 1)))

  (:action a-bad-6-242-2
    :parameters ()
    :precondition (and (at bad-5-80-2))
    :effect (and (not (at bad-5-80-2)) (at bad-6-242-2) (increase (total-cost) 1)))

  (:action finish-0
    :parameters ()
    :precondition (at bad-6-0-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-1
    :parameters ()
    :precondition (at bad-6-0-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-2
    :parameters ()
    :precondition (at bad-6-0-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-3
    :parameters ()
    :precondition (at bad-6-1-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-4
    :parameters ()
    :precondition (at bad-6-1-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-5
    :parameters ()
    :precondition (at bad-6-1-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-6
    :parameters ()
    :precondition (at bad-6-10-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-7
    :parameters ()
    :precondition (at bad-6-10-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-8
    :parameters ()
    :precondition (at bad-6-10-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-9
    :parameters ()
    :precondition (at bad-6-100-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-10
    :parameters ()
    :precondition (at bad-6-100-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-11
    :parameters ()
    :precondition (at bad-6-100-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-12
    :parameters ()
    :precondition (at bad-6-101-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-13
    :parameters ()
    :precondition (at bad-6-101-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-14
    :parameters ()
    :precondition (at bad-6-101-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-15
    :parameters ()
    :precondition (at bad-6-102-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-16
    :parameters ()
    :precondition (at bad-6-102-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-17
    :parameters ()
    :precondition (at bad-6-102-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-18
    :parameters ()
    :precondition (at bad-6-103-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-19
    :parameters ()
    :precondition (at bad-6-103-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-20
    :parameters ()
    :precondition (at bad-6-103-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-21
    :parameters ()
    :precondition (at bad-6-104-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-22
    :parameters ()
    :precondition (at bad-6-104-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-23
    :parameters ()
    :precondition (at bad-6-104-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-24
    :parameters ()
    :precondition (at bad-6-105-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-25
    :parameters ()
    :precondition (at bad-6-105-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-26
    :parameters ()
    :precondition (at bad-6-105-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-27
    :parameters ()
    :precondition (at bad-6-106-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-28
    :parameters ()
    :precondition (at bad-6-106-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-29
    :parameters ()
    :precondition (at bad-6-106-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-30
    :parameters ()
    :precondition (at bad-6-107-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-31
    :parameters ()
    :precondition (at bad-6-107-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-32
    :parameters ()
    :precondition (at bad-6-107-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-33
    :parameters ()
    :precondition (at bad-6-108-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-34
    :parameters ()
    :precondition (at bad-6-108-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-35
    :parameters ()
    :precondition (at bad-6-108-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-36
    :parameters ()
    :precondition (at bad-6-109-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-37
    :parameters ()
    :precondition (at bad-6-109-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-38
    :parameters ()
    :precondition (at bad-6-109-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-39
    :parameters ()
    :precondition (at bad-6-11-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-40
    :parameters ()
    :precondition (at bad-6-11-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-41
    :parameters ()
    :precondition (at bad-6-11-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-42
    :parameters ()
    :precondition (at bad-6-110-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-43
    :parameters ()
    :precondition (at bad-6-110-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-44
    :parameters ()
    :precondition (at bad-6-110-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-45
    :parameters ()
    :precondition (at bad-6-111-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-46
    :parameters ()
    :precondition (at bad-6-111-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-47
    :parameters ()
    :precondition (at bad-6-111-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-48
    :parameters ()
    :precondition (at bad-6-112-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-49
    :parameters ()
    :precondition (at bad-6-112-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-50
    :parameters ()
    :precondition (at bad-6-112-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-51
    :parameters ()
    :precondition (at bad-6-113-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-52
    :parameters ()
    :precondition (at bad-6-113-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-53
    :parameters ()
    :precondition (at bad-6-113-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-54
    :parameters ()
    :precondition (at bad-6-114-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-55
    :parameters ()
    :precondition (at bad-6-114-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-56
    :parameters ()
    :precondition (at bad-6-114-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-57
    :parameters ()
    :precondition (at bad-6-115-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-58
    :parameters ()
    :precondition (at bad-6-115-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-59
    :parameters ()
    :precondition (at bad-6-115-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-60
    :parameters ()
    :precondition (at bad-6-116-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-61
    :parameters ()
    :precondition (at bad-6-116-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-62
    :parameters ()
    :precondition (at bad-6-116-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-63
    :parameters ()
    :precondition (at bad-6-117-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-64
    :parameters ()
    :precondition (at bad-6-117-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-65
    :parameters ()
    :precondition (at bad-6-117-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-66
    :parameters ()
    :precondition (at bad-6-118-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-67
    :parameters ()
    :precondition (at bad-6-118-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-68
    :parameters ()
    :precondition (at bad-6-118-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-69
    :parameters ()
    :precondition (at bad-6-119-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-70
    :parameters ()
    :precondition (at bad-6-119-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-71
    :parameters ()
    :precondition (at bad-6-119-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-72
    :parameters ()
    :precondition (at bad-6-12-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-73
    :parameters ()
    :precondition (at bad-6-12-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-74
    :parameters ()
    :precondition (at bad-6-12-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-75
    :parameters ()
    :precondition (at bad-6-120-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-76
    :parameters ()
    :precondition (at bad-6-120-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-77
    :parameters ()
    :precondition (at bad-6-120-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-78
    :parameters ()
    :precondition (at bad-6-121-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-79
    :parameters ()
    :precondition (at bad-6-121-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-80
    :parameters ()
    :precondition (at bad-6-121-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-81
    :parameters ()
    :precondition (at bad-6-122-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-82
    :parameters ()
    :precondition (at bad-6-122-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-83
    :parameters ()
    :precondition (at bad-6-122-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-84
    :parameters ()
    :precondition (at bad-6-123-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-85
    :parameters ()
    :precondition (at bad-6-123-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-86
    :parameters ()
    :precondition (at bad-6-123-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-87
    :parameters ()
    :precondition (at bad-6-124-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-88
    :parameters ()
    :precondition (at bad-6-124-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-89
    :parameters ()
    :precondition (at bad-6-124-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-90
    :parameters ()
    :precondition (at bad-6-125-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-91
    :parameters ()
    :precondition (at bad-6-125-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-92
    :parameters ()
    :precondition (at bad-6-125-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-93
    :parameters ()
    :precondition (at bad-6-126-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-94
    :parameters ()
    :precondition (at bad-6-126-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-95
    :parameters ()
    :precondition (at bad-6-126-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-96
    :parameters ()
    :precondition (at bad-6-127-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-97
    :parameters ()
    :precondition (at bad-6-127-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-98
    :parameters ()
    :precondition (at bad-6-127-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-99
    :parameters ()
    :precondition (at bad-6-128-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-100
    :parameters ()
    :precondition (at bad-6-128-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-101
    :parameters ()
    :precondition (at bad-6-128-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-102
    :parameters ()
    :precondition (at bad-6-129-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-103
    :parameters ()
    :precondition (at bad-6-129-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-104
    :parameters ()
    :precondition (at bad-6-129-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-105
    :parameters ()
    :precondition (at bad-6-13-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-106
    :parameters ()
    :precondition (at bad-6-13-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-107
    :parameters ()
    :precondition (at bad-6-13-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-108
    :parameters ()
    :precondition (at bad-6-130-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-109
    :parameters ()
    :precondition (at bad-6-130-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-110
    :parameters ()
    :precondition (at bad-6-130-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-111
    :parameters ()
    :precondition (at bad-6-131-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-112
    :parameters ()
    :precondition (at bad-6-131-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-113
    :parameters ()
    :precondition (at bad-6-131-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-114
    :parameters ()
    :precondition (at bad-6-132-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-115
    :parameters ()
    :precondition (at bad-6-132-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-116
    :parameters ()
    :precondition (at bad-6-132-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-117
    :parameters ()
    :precondition (at bad-6-133-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-118
    :parameters ()
    :precondition (at bad-6-133-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-119
    :parameters ()
    :precondition (at bad-6-133-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-120
    :parameters ()
    :precondition (at bad-6-134-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-121
    :parameters ()
    :precondition (at bad-6-134-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-122
    :parameters ()
    :precondition (at bad-6-134-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-123
    :parameters ()
    :precondition (at bad-6-135-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-124
    :parameters ()
    :precondition (at bad-6-135-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-125
    :parameters ()
    :precondition (at bad-6-135-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-126
    :parameters ()
    :precondition (at bad-6-136-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-127
    :parameters ()
    :precondition (at bad-6-136-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-128
    :parameters ()
    :precondition (at bad-6-136-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-129
    :parameters ()
    :precondition (at bad-6-137-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-130
    :parameters ()
    :precondition (at bad-6-137-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-131
    :parameters ()
    :precondition (at bad-6-137-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-132
    :parameters ()
    :precondition (at bad-6-138-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-133
    :parameters ()
    :precondition (at bad-6-138-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-134
    :parameters ()
    :precondition (at bad-6-138-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-135
    :parameters ()
    :precondition (at bad-6-139-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-136
    :parameters ()
    :precondition (at bad-6-139-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-137
    :parameters ()
    :precondition (at bad-6-139-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-138
    :parameters ()
    :precondition (at bad-6-14-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-139
    :parameters ()
    :precondition (at bad-6-14-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-140
    :parameters ()
    :precondition (at bad-6-14-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-141
    :parameters ()
    :precondition (at bad-6-140-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-142
    :parameters ()
    :precondition (at bad-6-140-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-143
    :parameters ()
    :precondition (at bad-6-140-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-144
    :parameters ()
    :precondition (at bad-6-141-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-145
    :parameters ()
    :precondition (at bad-6-141-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-146
    :parameters ()
    :precondition (at bad-6-141-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-147
    :parameters ()
    :precondition (at bad-6-142-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-148
    :parameters ()
    :precondition (at bad-6-142-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-149
    :parameters ()
    :precondition (at bad-6-142-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-150
    :parameters ()
    :precondition (at bad-6-143-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-151
    :parameters ()
    :precondition (at bad-6-143-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-152
    :parameters ()
    :precondition (at bad-6-143-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-153
    :parameters ()
    :precondition (at bad-6-144-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-154
    :parameters ()
    :precondition (at bad-6-144-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-155
    :parameters ()
    :precondition (at bad-6-144-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-156
    :parameters ()
    :precondition (at bad-6-145-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-157
    :parameters ()
    :precondition (at bad-6-145-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-158
    :parameters ()
    :precondition (at bad-6-145-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-159
    :parameters ()
    :precondition (at bad-6-146-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-160
    :parameters ()
    :precondition (at bad-6-146-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-161
    :parameters ()
    :precondition (at bad-6-146-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-162
    :parameters ()
    :precondition (at bad-6-147-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-163
    :parameters ()
    :precondition (at bad-6-147-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-164
    :parameters ()
    :precondition (at bad-6-147-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-165
    :parameters ()
    :precondition (at bad-6-148-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-166
    :parameters ()
    :precondition (at bad-6-148-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-167
    :parameters ()
    :precondition (at bad-6-148-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-168
    :parameters ()
    :precondition (at bad-6-149-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-169
    :parameters ()
    :precondition (at bad-6-149-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-170
    :parameters ()
    :precondition (at bad-6-149-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-171
    :parameters ()
    :precondition (at bad-6-15-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-172
    :parameters ()
    :precondition (at bad-6-15-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-173
    :parameters ()
    :precondition (at bad-6-15-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-174
    :parameters ()
    :precondition (at bad-6-150-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-175
    :parameters ()
    :precondition (at bad-6-150-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-176
    :parameters ()
    :precondition (at bad-6-150-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-177
    :parameters ()
    :precondition (at bad-6-151-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-178
    :parameters ()
    :precondition (at bad-6-151-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-179
    :parameters ()
    :precondition (at bad-6-151-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-180
    :parameters ()
    :precondition (at bad-6-152-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-181
    :parameters ()
    :precondition (at bad-6-152-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-182
    :parameters ()
    :precondition (at bad-6-152-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-183
    :parameters ()
    :precondition (at bad-6-153-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-184
    :parameters ()
    :precondition (at bad-6-153-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-185
    :parameters ()
    :precondition (at bad-6-153-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-186
    :parameters ()
    :precondition (at bad-6-154-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-187
    :parameters ()
    :precondition (at bad-6-154-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-188
    :parameters ()
    :precondition (at bad-6-154-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-189
    :parameters ()
    :precondition (at bad-6-155-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-190
    :parameters ()
    :precondition (at bad-6-155-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-191
    :parameters ()
    :precondition (at bad-6-155-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-192
    :parameters ()
    :precondition (at bad-6-156-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-193
    :parameters ()
    :precondition (at bad-6-156-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-194
    :parameters ()
    :precondition (at bad-6-156-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-195
    :parameters ()
    :precondition (at bad-6-157-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-196
    :parameters ()
    :precondition (at bad-6-157-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-197
    :parameters ()
    :precondition (at bad-6-157-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-198
    :parameters ()
    :precondition (at bad-6-158-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-199
    :parameters ()
    :precondition (at bad-6-158-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-200
    :parameters ()
    :precondition (at bad-6-158-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-201
    :parameters ()
    :precondition (at bad-6-159-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-202
    :parameters ()
    :precondition (at bad-6-159-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-203
    :parameters ()
    :precondition (at bad-6-159-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-204
    :parameters ()
    :precondition (at bad-6-16-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-205
    :parameters ()
    :precondition (at bad-6-16-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-206
    :parameters ()
    :precondition (at bad-6-16-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-207
    :parameters ()
    :precondition (at bad-6-160-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-208
    :parameters ()
    :precondition (at bad-6-160-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-209
    :parameters ()
    :precondition (at bad-6-160-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-210
    :parameters ()
    :precondition (at bad-6-161-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-211
    :parameters ()
    :precondition (at bad-6-161-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-212
    :parameters ()
    :precondition (at bad-6-161-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-213
    :parameters ()
    :precondition (at bad-6-162-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-214
    :parameters ()
    :precondition (at bad-6-162-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-215
    :parameters ()
    :precondition (at bad-6-162-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-216
    :parameters ()
    :precondition (at bad-6-163-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-217
    :parameters ()
    :precondition (at bad-6-163-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-218
    :parameters ()
    :precondition (at bad-6-163-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-219
    :parameters ()
    :precondition (at bad-6-164-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-220
    :parameters ()
    :precondition (at bad-6-164-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-221
    :parameters ()
    :precondition (at bad-6-164-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-222
    :parameters ()
    :precondition (at bad-6-165-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-223
    :parameters ()
    :precondition (at bad-6-165-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-224
    :parameters ()
    :precondition (at bad-6-165-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-225
    :parameters ()
    :precondition (at bad-6-166-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-226
    :parameters ()
    :precondition (at bad-6-166-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-227
    :parameters ()
    :precondition (at bad-6-166-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-228
    :parameters ()
    :precondition (at bad-6-167-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-229
    :parameters ()
    :precondition (at bad-6-167-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-230
    :parameters ()
    :precondition (at bad-6-167-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-231
    :parameters ()
    :precondition (at bad-6-168-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-232
    :parameters ()
    :precondition (at bad-6-168-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-233
    :parameters ()
    :precondition (at bad-6-168-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-234
    :parameters ()
    :precondition (at bad-6-169-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-235
    :parameters ()
    :precondition (at bad-6-169-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-236
    :parameters ()
    :precondition (at bad-6-169-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-237
    :parameters ()
    :precondition (at bad-6-17-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-238
    :parameters ()
    :precondition (at bad-6-17-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-239
    :parameters ()
    :precondition (at bad-6-17-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-240
    :parameters ()
    :precondition (at bad-6-170-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-241
    :parameters ()
    :precondition (at bad-6-170-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-242
    :parameters ()
    :precondition (at bad-6-170-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-243
    :parameters ()
    :precondition (at bad-6-171-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-244
    :parameters ()
    :precondition (at bad-6-171-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-245
    :parameters ()
    :precondition (at bad-6-171-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-246
    :parameters ()
    :precondition (at bad-6-172-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-247
    :parameters ()
    :precondition (at bad-6-172-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-248
    :parameters ()
    :precondition (at bad-6-172-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-249
    :parameters ()
    :precondition (at bad-6-173-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-250
    :parameters ()
    :precondition (at bad-6-173-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-251
    :parameters ()
    :precondition (at bad-6-173-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-252
    :parameters ()
    :precondition (at bad-6-174-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-253
    :parameters ()
    :precondition (at bad-6-174-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-254
    :parameters ()
    :precondition (at bad-6-174-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-255
    :parameters ()
    :precondition (at bad-6-175-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-256
    :parameters ()
    :precondition (at bad-6-175-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-257
    :parameters ()
    :precondition (at bad-6-175-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-258
    :parameters ()
    :precondition (at bad-6-176-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-259
    :parameters ()
    :precondition (at bad-6-176-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-260
    :parameters ()
    :precondition (at bad-6-176-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-261
    :parameters ()
    :precondition (at bad-6-177-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-262
    :parameters ()
    :precondition (at bad-6-177-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-263
    :parameters ()
    :precondition (at bad-6-177-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-264
    :parameters ()
    :precondition (at bad-6-178-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-265
    :parameters ()
    :precondition (at bad-6-178-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-266
    :parameters ()
    :precondition (at bad-6-178-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-267
    :parameters ()
    :precondition (at bad-6-179-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-268
    :parameters ()
    :precondition (at bad-6-179-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-269
    :parameters ()
    :precondition (at bad-6-179-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-270
    :parameters ()
    :precondition (at bad-6-18-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-271
    :parameters ()
    :precondition (at bad-6-18-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-272
    :parameters ()
    :precondition (at bad-6-18-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-273
    :parameters ()
    :precondition (at bad-6-180-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-274
    :parameters ()
    :precondition (at bad-6-180-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-275
    :parameters ()
    :precondition (at bad-6-180-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-276
    :parameters ()
    :precondition (at bad-6-181-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-277
    :parameters ()
    :precondition (at bad-6-181-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-278
    :parameters ()
    :precondition (at bad-6-181-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-279
    :parameters ()
    :precondition (at bad-6-182-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-280
    :parameters ()
    :precondition (at bad-6-182-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-281
    :parameters ()
    :precondition (at bad-6-182-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-282
    :parameters ()
    :precondition (at bad-6-183-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-283
    :parameters ()
    :precondition (at bad-6-183-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-284
    :parameters ()
    :precondition (at bad-6-183-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-285
    :parameters ()
    :precondition (at bad-6-184-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-286
    :parameters ()
    :precondition (at bad-6-184-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-287
    :parameters ()
    :precondition (at bad-6-184-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-288
    :parameters ()
    :precondition (at bad-6-185-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-289
    :parameters ()
    :precondition (at bad-6-185-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-290
    :parameters ()
    :precondition (at bad-6-185-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-291
    :parameters ()
    :precondition (at bad-6-186-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-292
    :parameters ()
    :precondition (at bad-6-186-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-293
    :parameters ()
    :precondition (at bad-6-186-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-294
    :parameters ()
    :precondition (at bad-6-187-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-295
    :parameters ()
    :precondition (at bad-6-187-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-296
    :parameters ()
    :precondition (at bad-6-187-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-297
    :parameters ()
    :precondition (at bad-6-188-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-298
    :parameters ()
    :precondition (at bad-6-188-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-299
    :parameters ()
    :precondition (at bad-6-188-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-300
    :parameters ()
    :precondition (at bad-6-189-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-301
    :parameters ()
    :precondition (at bad-6-189-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-302
    :parameters ()
    :precondition (at bad-6-189-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-303
    :parameters ()
    :precondition (at bad-6-19-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-304
    :parameters ()
    :precondition (at bad-6-19-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-305
    :parameters ()
    :precondition (at bad-6-19-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-306
    :parameters ()
    :precondition (at bad-6-190-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-307
    :parameters ()
    :precondition (at bad-6-190-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-308
    :parameters ()
    :precondition (at bad-6-190-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-309
    :parameters ()
    :precondition (at bad-6-191-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-310
    :parameters ()
    :precondition (at bad-6-191-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-311
    :parameters ()
    :precondition (at bad-6-191-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-312
    :parameters ()
    :precondition (at bad-6-192-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-313
    :parameters ()
    :precondition (at bad-6-192-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-314
    :parameters ()
    :precondition (at bad-6-192-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-315
    :parameters ()
    :precondition (at bad-6-193-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-316
    :parameters ()
    :precondition (at bad-6-193-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-317
    :parameters ()
    :precondition (at bad-6-193-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-318
    :parameters ()
    :precondition (at bad-6-194-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-319
    :parameters ()
    :precondition (at bad-6-194-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-320
    :parameters ()
    :precondition (at bad-6-194-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-321
    :parameters ()
    :precondition (at bad-6-195-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-322
    :parameters ()
    :precondition (at bad-6-195-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-323
    :parameters ()
    :precondition (at bad-6-195-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-324
    :parameters ()
    :precondition (at bad-6-196-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-325
    :parameters ()
    :precondition (at bad-6-196-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-326
    :parameters ()
    :precondition (at bad-6-196-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-327
    :parameters ()
    :precondition (at bad-6-197-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-328
    :parameters ()
    :precondition (at bad-6-197-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-329
    :parameters ()
    :precondition (at bad-6-197-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-330
    :parameters ()
    :precondition (at bad-6-198-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-331
    :parameters ()
    :precondition (at bad-6-198-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-332
    :parameters ()
    :precondition (at bad-6-198-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-333
    :parameters ()
    :precondition (at bad-6-199-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-334
    :parameters ()
    :precondition (at bad-6-199-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-335
    :parameters ()
    :precondition (at bad-6-199-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-336
    :parameters ()
    :precondition (at bad-6-2-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-337
    :parameters ()
    :precondition (at bad-6-2-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-338
    :parameters ()
    :precondition (at bad-6-2-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-339
    :parameters ()
    :precondition (at bad-6-20-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-340
    :parameters ()
    :precondition (at bad-6-20-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-341
    :parameters ()
    :precondition (at bad-6-20-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-342
    :parameters ()
    :precondition (at bad-6-200-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-343
    :parameters ()
    :precondition (at bad-6-200-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-344
    :parameters ()
    :precondition (at bad-6-200-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-345
    :parameters ()
    :precondition (at bad-6-201-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-346
    :parameters ()
    :precondition (at bad-6-201-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-347
    :parameters ()
    :precondition (at bad-6-201-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-348
    :parameters ()
    :precondition (at bad-6-202-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-349
    :parameters ()
    :precondition (at bad-6-202-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-350
    :parameters ()
    :precondition (at bad-6-202-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-351
    :parameters ()
    :precondition (at bad-6-203-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-352
    :parameters ()
    :precondition (at bad-6-203-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-353
    :parameters ()
    :precondition (at bad-6-203-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-354
    :parameters ()
    :precondition (at bad-6-204-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-355
    :parameters ()
    :precondition (at bad-6-204-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-356
    :parameters ()
    :precondition (at bad-6-204-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-357
    :parameters ()
    :precondition (at bad-6-205-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-358
    :parameters ()
    :precondition (at bad-6-205-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-359
    :parameters ()
    :precondition (at bad-6-205-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-360
    :parameters ()
    :precondition (at bad-6-206-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-361
    :parameters ()
    :precondition (at bad-6-206-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-362
    :parameters ()
    :precondition (at bad-6-206-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-363
    :parameters ()
    :precondition (at bad-6-207-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-364
    :parameters ()
    :precondition (at bad-6-207-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-365
    :parameters ()
    :precondition (at bad-6-207-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-366
    :parameters ()
    :precondition (at bad-6-208-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-367
    :parameters ()
    :precondition (at bad-6-208-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-368
    :parameters ()
    :precondition (at bad-6-208-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-369
    :parameters ()
    :precondition (at bad-6-209-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-370
    :parameters ()
    :precondition (at bad-6-209-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-371
    :parameters ()
    :precondition (at bad-6-209-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-372
    :parameters ()
    :precondition (at bad-6-21-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-373
    :parameters ()
    :precondition (at bad-6-21-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-374
    :parameters ()
    :precondition (at bad-6-21-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-375
    :parameters ()
    :precondition (at bad-6-210-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-376
    :parameters ()
    :precondition (at bad-6-210-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-377
    :parameters ()
    :precondition (at bad-6-210-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-378
    :parameters ()
    :precondition (at bad-6-211-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-379
    :parameters ()
    :precondition (at bad-6-211-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-380
    :parameters ()
    :precondition (at bad-6-211-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-381
    :parameters ()
    :precondition (at bad-6-212-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-382
    :parameters ()
    :precondition (at bad-6-212-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-383
    :parameters ()
    :precondition (at bad-6-212-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-384
    :parameters ()
    :precondition (at bad-6-213-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-385
    :parameters ()
    :precondition (at bad-6-213-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-386
    :parameters ()
    :precondition (at bad-6-213-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-387
    :parameters ()
    :precondition (at bad-6-214-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-388
    :parameters ()
    :precondition (at bad-6-214-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-389
    :parameters ()
    :precondition (at bad-6-214-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-390
    :parameters ()
    :precondition (at bad-6-215-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-391
    :parameters ()
    :precondition (at bad-6-215-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-392
    :parameters ()
    :precondition (at bad-6-215-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-393
    :parameters ()
    :precondition (at bad-6-216-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-394
    :parameters ()
    :precondition (at bad-6-216-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-395
    :parameters ()
    :precondition (at bad-6-216-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-396
    :parameters ()
    :precondition (at bad-6-217-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-397
    :parameters ()
    :precondition (at bad-6-217-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-398
    :parameters ()
    :precondition (at bad-6-217-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-399
    :parameters ()
    :precondition (at bad-6-218-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-400
    :parameters ()
    :precondition (at bad-6-218-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-401
    :parameters ()
    :precondition (at bad-6-218-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-402
    :parameters ()
    :precondition (at bad-6-219-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-403
    :parameters ()
    :precondition (at bad-6-219-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-404
    :parameters ()
    :precondition (at bad-6-219-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-405
    :parameters ()
    :precondition (at bad-6-22-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-406
    :parameters ()
    :precondition (at bad-6-22-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-407
    :parameters ()
    :precondition (at bad-6-22-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-408
    :parameters ()
    :precondition (at bad-6-220-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-409
    :parameters ()
    :precondition (at bad-6-220-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-410
    :parameters ()
    :precondition (at bad-6-220-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-411
    :parameters ()
    :precondition (at bad-6-221-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-412
    :parameters ()
    :precondition (at bad-6-221-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-413
    :parameters ()
    :precondition (at bad-6-221-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-414
    :parameters ()
    :precondition (at bad-6-222-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-415
    :parameters ()
    :precondition (at bad-6-222-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-416
    :parameters ()
    :precondition (at bad-6-222-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-417
    :parameters ()
    :precondition (at bad-6-223-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-418
    :parameters ()
    :precondition (at bad-6-223-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-419
    :parameters ()
    :precondition (at bad-6-223-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-420
    :parameters ()
    :precondition (at bad-6-224-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-421
    :parameters ()
    :precondition (at bad-6-224-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-422
    :parameters ()
    :precondition (at bad-6-224-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-423
    :parameters ()
    :precondition (at bad-6-225-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-424
    :parameters ()
    :precondition (at bad-6-225-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-425
    :parameters ()
    :precondition (at bad-6-225-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-426
    :parameters ()
    :precondition (at bad-6-226-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-427
    :parameters ()
    :precondition (at bad-6-226-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-428
    :parameters ()
    :precondition (at bad-6-226-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-429
    :parameters ()
    :precondition (at bad-6-227-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-430
    :parameters ()
    :precondition (at bad-6-227-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-431
    :parameters ()
    :precondition (at bad-6-227-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-432
    :parameters ()
    :precondition (at bad-6-228-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-433
    :parameters ()
    :precondition (at bad-6-228-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-434
    :parameters ()
    :precondition (at bad-6-228-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-435
    :parameters ()
    :precondition (at bad-6-229-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-436
    :parameters ()
    :precondition (at bad-6-229-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-437
    :parameters ()
    :precondition (at bad-6-229-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-438
    :parameters ()
    :precondition (at bad-6-23-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-439
    :parameters ()
    :precondition (at bad-6-23-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-440
    :parameters ()
    :precondition (at bad-6-23-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-441
    :parameters ()
    :precondition (at bad-6-230-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-442
    :parameters ()
    :precondition (at bad-6-230-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-443
    :parameters ()
    :precondition (at bad-6-230-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-444
    :parameters ()
    :precondition (at bad-6-231-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-445
    :parameters ()
    :precondition (at bad-6-231-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-446
    :parameters ()
    :precondition (at bad-6-231-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-447
    :parameters ()
    :precondition (at bad-6-232-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-448
    :parameters ()
    :precondition (at bad-6-232-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-449
    :parameters ()
    :precondition (at bad-6-232-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-450
    :parameters ()
    :precondition (at bad-6-233-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-451
    :parameters ()
    :precondition (at bad-6-233-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-452
    :parameters ()
    :precondition (at bad-6-233-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-453
    :parameters ()
    :precondition (at bad-6-234-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-454
    :parameters ()
    :precondition (at bad-6-234-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-455
    :parameters ()
    :precondition (at bad-6-234-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-456
    :parameters ()
    :precondition (at bad-6-235-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-457
    :parameters ()
    :precondition (at bad-6-235-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-458
    :parameters ()
    :precondition (at bad-6-235-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-459
    :parameters ()
    :precondition (at bad-6-236-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-460
    :parameters ()
    :precondition (at bad-6-236-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-461
    :parameters ()
    :precondition (at bad-6-236-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-462
    :parameters ()
    :precondition (at bad-6-237-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-463
    :parameters ()
    :precondition (at bad-6-237-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-464
    :parameters ()
    :precondition (at bad-6-237-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-465
    :parameters ()
    :precondition (at bad-6-238-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-466
    :parameters ()
    :precondition (at bad-6-238-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-467
    :parameters ()
    :precondition (at bad-6-238-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-468
    :parameters ()
    :precondition (at bad-6-239-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-469
    :parameters ()
    :precondition (at bad-6-239-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-470
    :parameters ()
    :precondition (at bad-6-239-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-471
    :parameters ()
    :precondition (at bad-6-24-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-472
    :parameters ()
    :precondition (at bad-6-24-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-473
    :parameters ()
    :precondition (at bad-6-24-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-474
    :parameters ()
    :precondition (at bad-6-240-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-475
    :parameters ()
    :precondition (at bad-6-240-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-476
    :parameters ()
    :precondition (at bad-6-240-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-477
    :parameters ()
    :precondition (at bad-6-241-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-478
    :parameters ()
    :precondition (at bad-6-241-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-479
    :parameters ()
    :precondition (at bad-6-241-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-480
    :parameters ()
    :precondition (at bad-6-242-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-481
    :parameters ()
    :precondition (at bad-6-242-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-482
    :parameters ()
    :precondition (at bad-6-242-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-483
    :parameters ()
    :precondition (at bad-6-25-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-484
    :parameters ()
    :precondition (at bad-6-25-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-485
    :parameters ()
    :precondition (at bad-6-25-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-486
    :parameters ()
    :precondition (at bad-6-26-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-487
    :parameters ()
    :precondition (at bad-6-26-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-488
    :parameters ()
    :precondition (at bad-6-26-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-489
    :parameters ()
    :precondition (at bad-6-27-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-490
    :parameters ()
    :precondition (at bad-6-27-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-491
    :parameters ()
    :precondition (at bad-6-27-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-492
    :parameters ()
    :precondition (at bad-6-28-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-493
    :parameters ()
    :precondition (at bad-6-28-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-494
    :parameters ()
    :precondition (at bad-6-28-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-495
    :parameters ()
    :precondition (at bad-6-29-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-496
    :parameters ()
    :precondition (at bad-6-29-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-497
    :parameters ()
    :precondition (at bad-6-29-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-498
    :parameters ()
    :precondition (at bad-6-3-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-499
    :parameters ()
    :precondition (at bad-6-3-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-500
    :parameters ()
    :precondition (at bad-6-3-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-501
    :parameters ()
    :precondition (at bad-6-30-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-502
    :parameters ()
    :precondition (at bad-6-30-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-503
    :parameters ()
    :precondition (at bad-6-30-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-504
    :parameters ()
    :precondition (at bad-6-31-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-505
    :parameters ()
    :precondition (at bad-6-31-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-506
    :parameters ()
    :precondition (at bad-6-31-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-507
    :parameters ()
    :precondition (at bad-6-32-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-508
    :parameters ()
    :precondition (at bad-6-32-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-509
    :parameters ()
    :precondition (at bad-6-32-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-510
    :parameters ()
    :precondition (at bad-6-33-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-511
    :parameters ()
    :precondition (at bad-6-33-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-512
    :parameters ()
    :precondition (at bad-6-33-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-513
    :parameters ()
    :precondition (at bad-6-34-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-514
    :parameters ()
    :precondition (at bad-6-34-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-515
    :parameters ()
    :precondition (at bad-6-34-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-516
    :parameters ()
    :precondition (at bad-6-35-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-517
    :parameters ()
    :precondition (at bad-6-35-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-518
    :parameters ()
    :precondition (at bad-6-35-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-519
    :parameters ()
    :precondition (at bad-6-36-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-520
    :parameters ()
    :precondition (at bad-6-36-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-521
    :parameters ()
    :precondition (at bad-6-36-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-522
    :parameters ()
    :precondition (at bad-6-37-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-523
    :parameters ()
    :precondition (at bad-6-37-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-524
    :parameters ()
    :precondition (at bad-6-37-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-525
    :parameters ()
    :precondition (at bad-6-38-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-526
    :parameters ()
    :precondition (at bad-6-38-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-527
    :parameters ()
    :precondition (at bad-6-38-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-528
    :parameters ()
    :precondition (at bad-6-39-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-529
    :parameters ()
    :precondition (at bad-6-39-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-530
    :parameters ()
    :precondition (at bad-6-39-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-531
    :parameters ()
    :precondition (at bad-6-4-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-532
    :parameters ()
    :precondition (at bad-6-4-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-533
    :parameters ()
    :precondition (at bad-6-4-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-534
    :parameters ()
    :precondition (at bad-6-40-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-535
    :parameters ()
    :precondition (at bad-6-40-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-536
    :parameters ()
    :precondition (at bad-6-40-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-537
    :parameters ()
    :precondition (at bad-6-41-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-538
    :parameters ()
    :precondition (at bad-6-41-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-539
    :parameters ()
    :precondition (at bad-6-41-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-540
    :parameters ()
    :precondition (at bad-6-42-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-541
    :parameters ()
    :precondition (at bad-6-42-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-542
    :parameters ()
    :precondition (at bad-6-42-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-543
    :parameters ()
    :precondition (at bad-6-43-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-544
    :parameters ()
    :precondition (at bad-6-43-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-545
    :parameters ()
    :precondition (at bad-6-43-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-546
    :parameters ()
    :precondition (at bad-6-44-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-547
    :parameters ()
    :precondition (at bad-6-44-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-548
    :parameters ()
    :precondition (at bad-6-44-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-549
    :parameters ()
    :precondition (at bad-6-45-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-550
    :parameters ()
    :precondition (at bad-6-45-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-551
    :parameters ()
    :precondition (at bad-6-45-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-552
    :parameters ()
    :precondition (at bad-6-46-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-553
    :parameters ()
    :precondition (at bad-6-46-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-554
    :parameters ()
    :precondition (at bad-6-46-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-555
    :parameters ()
    :precondition (at bad-6-47-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-556
    :parameters ()
    :precondition (at bad-6-47-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-557
    :parameters ()
    :precondition (at bad-6-47-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-558
    :parameters ()
    :precondition (at bad-6-48-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-559
    :parameters ()
    :precondition (at bad-6-48-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-560
    :parameters ()
    :precondition (at bad-6-48-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-561
    :parameters ()
    :precondition (at bad-6-49-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-562
    :parameters ()
    :precondition (at bad-6-49-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-563
    :parameters ()
    :precondition (at bad-6-49-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-564
    :parameters ()
    :precondition (at bad-6-5-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-565
    :parameters ()
    :precondition (at bad-6-5-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-566
    :parameters ()
    :precondition (at bad-6-5-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-567
    :parameters ()
    :precondition (at bad-6-50-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-568
    :parameters ()
    :precondition (at bad-6-50-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-569
    :parameters ()
    :precondition (at bad-6-50-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-570
    :parameters ()
    :precondition (at bad-6-51-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-571
    :parameters ()
    :precondition (at bad-6-51-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-572
    :parameters ()
    :precondition (at bad-6-51-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-573
    :parameters ()
    :precondition (at bad-6-52-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-574
    :parameters ()
    :precondition (at bad-6-52-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-575
    :parameters ()
    :precondition (at bad-6-52-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-576
    :parameters ()
    :precondition (at bad-6-53-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-577
    :parameters ()
    :precondition (at bad-6-53-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-578
    :parameters ()
    :precondition (at bad-6-53-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-579
    :parameters ()
    :precondition (at bad-6-54-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-580
    :parameters ()
    :precondition (at bad-6-54-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-581
    :parameters ()
    :precondition (at bad-6-54-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-582
    :parameters ()
    :precondition (at bad-6-55-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-583
    :parameters ()
    :precondition (at bad-6-55-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-584
    :parameters ()
    :precondition (at bad-6-55-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-585
    :parameters ()
    :precondition (at bad-6-56-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-586
    :parameters ()
    :precondition (at bad-6-56-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-587
    :parameters ()
    :precondition (at bad-6-56-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-588
    :parameters ()
    :precondition (at bad-6-57-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-589
    :parameters ()
    :precondition (at bad-6-57-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-590
    :parameters ()
    :precondition (at bad-6-57-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-591
    :parameters ()
    :precondition (at bad-6-58-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-592
    :parameters ()
    :precondition (at bad-6-58-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-593
    :parameters ()
    :precondition (at bad-6-58-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-594
    :parameters ()
    :precondition (at bad-6-59-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-595
    :parameters ()
    :precondition (at bad-6-59-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-596
    :parameters ()
    :precondition (at bad-6-59-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-597
    :parameters ()
    :precondition (at bad-6-6-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-598
    :parameters ()
    :precondition (at bad-6-6-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-599
    :parameters ()
    :precondition (at bad-6-6-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-600
    :parameters ()
    :precondition (at bad-6-60-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-601
    :parameters ()
    :precondition (at bad-6-60-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-602
    :parameters ()
    :precondition (at bad-6-60-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-603
    :parameters ()
    :precondition (at bad-6-61-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-604
    :parameters ()
    :precondition (at bad-6-61-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-605
    :parameters ()
    :precondition (at bad-6-61-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-606
    :parameters ()
    :precondition (at bad-6-62-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-607
    :parameters ()
    :precondition (at bad-6-62-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-608
    :parameters ()
    :precondition (at bad-6-62-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-609
    :parameters ()
    :precondition (at bad-6-63-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-610
    :parameters ()
    :precondition (at bad-6-63-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-611
    :parameters ()
    :precondition (at bad-6-63-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-612
    :parameters ()
    :precondition (at bad-6-64-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-613
    :parameters ()
    :precondition (at bad-6-64-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-614
    :parameters ()
    :precondition (at bad-6-64-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-615
    :parameters ()
    :precondition (at bad-6-65-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-616
    :parameters ()
    :precondition (at bad-6-65-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-617
    :parameters ()
    :precondition (at bad-6-65-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-618
    :parameters ()
    :precondition (at bad-6-66-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-619
    :parameters ()
    :precondition (at bad-6-66-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-620
    :parameters ()
    :precondition (at bad-6-66-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-621
    :parameters ()
    :precondition (at bad-6-67-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-622
    :parameters ()
    :precondition (at bad-6-67-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-623
    :parameters ()
    :precondition (at bad-6-67-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-624
    :parameters ()
    :precondition (at bad-6-68-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-625
    :parameters ()
    :precondition (at bad-6-68-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-626
    :parameters ()
    :precondition (at bad-6-68-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-627
    :parameters ()
    :precondition (at bad-6-69-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-628
    :parameters ()
    :precondition (at bad-6-69-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-629
    :parameters ()
    :precondition (at bad-6-69-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-630
    :parameters ()
    :precondition (at bad-6-7-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-631
    :parameters ()
    :precondition (at bad-6-7-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-632
    :parameters ()
    :precondition (at bad-6-7-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-633
    :parameters ()
    :precondition (at bad-6-70-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-634
    :parameters ()
    :precondition (at bad-6-70-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-635
    :parameters ()
    :precondition (at bad-6-70-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-636
    :parameters ()
    :precondition (at bad-6-71-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-637
    :parameters ()
    :precondition (at bad-6-71-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-638
    :parameters ()
    :precondition (at bad-6-71-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-639
    :parameters ()
    :precondition (at bad-6-72-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-640
    :parameters ()
    :precondition (at bad-6-72-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-641
    :parameters ()
    :precondition (at bad-6-72-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-642
    :parameters ()
    :precondition (at bad-6-73-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-643
    :parameters ()
    :precondition (at bad-6-73-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-644
    :parameters ()
    :precondition (at bad-6-73-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-645
    :parameters ()
    :precondition (at bad-6-74-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-646
    :parameters ()
    :precondition (at bad-6-74-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-647
    :parameters ()
    :precondition (at bad-6-74-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-648
    :parameters ()
    :precondition (at bad-6-75-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-649
    :parameters ()
    :precondition (at bad-6-75-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-650
    :parameters ()
    :precondition (at bad-6-75-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-651
    :parameters ()
    :precondition (at bad-6-76-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-652
    :parameters ()
    :precondition (at bad-6-76-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-653
    :parameters ()
    :precondition (at bad-6-76-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-654
    :parameters ()
    :precondition (at bad-6-77-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-655
    :parameters ()
    :precondition (at bad-6-77-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-656
    :parameters ()
    :precondition (at bad-6-77-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-657
    :parameters ()
    :precondition (at bad-6-78-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-658
    :parameters ()
    :precondition (at bad-6-78-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-659
    :parameters ()
    :precondition (at bad-6-78-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-660
    :parameters ()
    :precondition (at bad-6-79-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-661
    :parameters ()
    :precondition (at bad-6-79-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-662
    :parameters ()
    :precondition (at bad-6-79-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-663
    :parameters ()
    :precondition (at bad-6-8-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-664
    :parameters ()
    :precondition (at bad-6-8-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-665
    :parameters ()
    :precondition (at bad-6-8-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-666
    :parameters ()
    :precondition (at bad-6-80-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-667
    :parameters ()
    :precondition (at bad-6-80-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-668
    :parameters ()
    :precondition (at bad-6-80-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-669
    :parameters ()
    :precondition (at bad-6-81-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-670
    :parameters ()
    :precondition (at bad-6-81-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-671
    :parameters ()
    :precondition (at bad-6-81-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-672
    :parameters ()
    :precondition (at bad-6-82-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-673
    :parameters ()
    :precondition (at bad-6-82-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-674
    :parameters ()
    :precondition (at bad-6-82-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-675
    :parameters ()
    :precondition (at bad-6-83-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-676
    :parameters ()
    :precondition (at bad-6-83-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-677
    :parameters ()
    :precondition (at bad-6-83-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-678
    :parameters ()
    :precondition (at bad-6-84-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-679
    :parameters ()
    :precondition (at bad-6-84-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-680
    :parameters ()
    :precondition (at bad-6-84-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-681
    :parameters ()
    :precondition (at bad-6-85-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-682
    :parameters ()
    :precondition (at bad-6-85-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-683
    :parameters ()
    :precondition (at bad-6-85-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-684
    :parameters ()
    :precondition (at bad-6-86-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-685
    :parameters ()
    :precondition (at bad-6-86-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-686
    :parameters ()
    :precondition (at bad-6-86-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-687
    :parameters ()
    :precondition (at bad-6-87-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-688
    :parameters ()
    :precondition (at bad-6-87-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-689
    :parameters ()
    :precondition (at bad-6-87-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-690
    :parameters ()
    :precondition (at bad-6-88-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-691
    :parameters ()
    :precondition (at bad-6-88-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-692
    :parameters ()
    :precondition (at bad-6-88-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-693
    :parameters ()
    :precondition (at bad-6-89-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-694
    :parameters ()
    :precondition (at bad-6-89-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-695
    :parameters ()
    :precondition (at bad-6-89-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-696
    :parameters ()
    :precondition (at bad-6-9-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-697
    :parameters ()
    :precondition (at bad-6-9-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-698
    :parameters ()
    :precondition (at bad-6-9-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-699
    :parameters ()
    :precondition (at bad-6-90-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-700
    :parameters ()
    :precondition (at bad-6-90-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-701
    :parameters ()
    :precondition (at bad-6-90-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-702
    :parameters ()
    :precondition (at bad-6-91-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-703
    :parameters ()
    :precondition (at bad-6-91-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-704
    :parameters ()
    :precondition (at bad-6-91-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-705
    :parameters ()
    :precondition (at bad-6-92-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-706
    :parameters ()
    :precondition (at bad-6-92-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-707
    :parameters ()
    :precondition (at bad-6-92-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-708
    :parameters ()
    :precondition (at bad-6-93-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-709
    :parameters ()
    :precondition (at bad-6-93-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-710
    :parameters ()
    :precondition (at bad-6-93-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-711
    :parameters ()
    :precondition (at bad-6-94-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-712
    :parameters ()
    :precondition (at bad-6-94-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-713
    :parameters ()
    :precondition (at bad-6-94-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-714
    :parameters ()
    :precondition (at bad-6-95-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-715
    :parameters ()
    :precondition (at bad-6-95-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-716
    :parameters ()
    :precondition (at bad-6-95-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-717
    :parameters ()
    :precondition (at bad-6-96-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-718
    :parameters ()
    :precondition (at bad-6-96-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-719
    :parameters ()
    :precondition (at bad-6-96-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-720
    :parameters ()
    :precondition (at bad-6-97-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-721
    :parameters ()
    :precondition (at bad-6-97-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-722
    :parameters ()
    :precondition (at bad-6-97-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-723
    :parameters ()
    :precondition (at bad-6-98-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-724
    :parameters ()
    :precondition (at bad-6-98-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-725
    :parameters ()
    :precondition (at bad-6-98-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-726
    :parameters ()
    :precondition (at bad-6-99-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-727
    :parameters ()
    :precondition (at bad-6-99-1)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-728
    :parameters ()
    :precondition (at bad-6-99-2)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-729
    :parameters ()
    :precondition (at good-8)
    :effect (and (done) (increase (total-cost) 1)))
)
