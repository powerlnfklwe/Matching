package com.gather.we.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gather.we.dao.GameSchedulerDAO;
import com.gather.we.dto.GameSchedulerDTO;

@Service
public class GameSchedulerServiceImpl implements GameSchedulerService {
	@Inject
	GameSchedulerDAO dao;

	@Override
	public List<GameSchedulerDTO> statusUpdateListSelect() {
		return dao.statusUpdateListSelect();
	}

	@Override
	public int statusUpdate(GameSchedulerDTO dto) {
		return dao.statusUpdate(dto);
	}

	@Override
	public List<GameSchedulerDTO> normStatusUpdateListSelect() {
		return dao.normStatusUpdateListSelect();
	}

	@Override
	public int normStatusUpdate(GameSchedulerDTO dto) {
		return dao.normStatusUpdate(dto);
	}
}
